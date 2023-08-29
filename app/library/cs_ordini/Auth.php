<?php

namespace cs_ordini;

use DateTimeImmutable;
use Phalcon\Encryption\Security\JWT\Builder;
use Phalcon\Encryption\Security\JWT\Signer\Hmac;
use Phalcon\Encryption\Security\JWT\Token\Enum;
use Phalcon\Encryption\Security\JWT\Token\Parser;
use Phalcon\Encryption\Security\JWT\Validator;
use Phalcon\Http\Response;
use cs_ordini\Finder;

class Auth extends \cs_ordini\_base {

  private array $aCredentialsAuth = ['user' => '', 'pass' => ''];

  public function checkAuth($functionParams) {
    $response = ['authorized' => \false];
    $this->authorized = \false;
    // $auth = [0 => '', 1 => ''];
    if (\property_exists($functionParams, 'type')) {
      $authorizationHeader = '';
      $typeAuth = '';
      $token = '';
      $headers = getallheaders();
      if (isset($headers['Authorization'])) {
        $authorizationHeader = $headers['Authorization'];
      }
      if ('' !== $authorizationHeader) {
        $typeAuth = trim(\strtolower(\substr($authorizationHeader, 0, 6)));
        $token = \trim(\substr($authorizationHeader, 6));
        $aCredentialsAuth = explode(':', \base64_decode($token));
        if (is_array($aCredentialsAuth) && count($aCredentialsAuth) == 2) {
          $this->aCredentialsAuth['user'] = $aCredentialsAuth[0];
          $this->aCredentialsAuth['pass'] = $aCredentialsAuth[1];
        }
      }
      if ($functionParams->type == 'none') {
        $response = ['authorized' => \true];
        $this->authorized = \true;
      }
      if ('basic' == $functionParams->type  && 'basic' == $typeAuth) {
        if (\property_exists($functionParams, 'validation')) {
          switch (true) {
            case $functionParams->validation == 'db':
              $response = $this->findUserFromDb($this->aCredentialsAuth['user'], $this->aCredentialsAuth['pass']);
              break;
            case $functionParams->validation == 'json':
              $response = $this->findUserFromJson($this->aCredentialsAuth['user'], $this->aCredentialsAuth['pass']);
              break;
            case $functionParams->validation == 'ldap':
              $response = $this->findUserFromLdap($this->aCredentialsAuth['user'], $this->aCredentialsAuth['pass']);
              break;
            default:
              # code...
              break;
          }
        }
      }
      if (
        $functionParams->type == 'bearer' && $typeAuth == 'bearer' &&
        \property_exists($functionParams, 'bearerToken') &&
        $functionParams->bearerToken != '' &&
        $functionParams->bearerToken == $token
      ) {
        $response = ['authorized' => \true];
        $this->authorized = \true;
      }
      if (
        $functionParams->type == 'jwt' &&
        \property_exists($functionParams, 'jwtParams') &&
        \is_object($functionParams->jwtParams)
      ) {
        $now            = new DateTimeImmutable();
        $issuedAt       = $now->getTimestamp();
        $dateModified   = $now->modify($functionParams->jwtParams->notBefore);
        if ($dateModified) {
          $notBefore    = $dateModified->getTimestamp();
        } else {
          $notBefore    = $issuedAt;
        }

        // 'sha512'
        $signer         = new Hmac();
        $expirationTime = $now->getTimestamp();
        $parser         = new Parser();
        // Phalcon\Encryption\Security\JWT\Token\Token 
        $tokenObject    = $parser->parse($token);

        // Phalcon\Encryption\Security\JWT\Validator 
        $validator      = new Validator($tokenObject, 100); // allow for a time shift of 100
        $validator
          ->set(Enum::AUDIENCE, $functionParams->jwtParams->aud)
          ->set(Enum::EXPIRATION_TIME, $expirationTime)
          ->set(Enum::ID, $tokenObject->getClaims()->getPayload()['jti'])
          ->set(Enum::ISSUED_AT, $issuedAt)
          ->set(Enum::ISSUER, $functionParams->jwtParams->iss)
          ->set(Enum::NOT_BEFORE, $notBefore)
          ->set(Enum::SUBJECT, $functionParams->jwtParams->sub);

        $tokenObject->verify($signer, $functionParams->jwtParams->passphrase);
        $errors = $tokenObject->validate($validator);
        if ($errors) {
          $response['errors']['code'] = Response::STATUS_UNAUTHORIZED;
          $response['errors']['list'] = $errors;
        } else {
          $this->authorized = \true;
        }
      }
    }
    $response['authorized'] = $this->authorized;
    return $response;
  }

  public function checkAuthPdnd($functionParams) {
  }

  public function createAuthJwt($functionParams) {
    $token = '';
    if (\property_exists($functionParams, 'jwtParams') && \is_object($functionParams->jwtParams)) {
      $now            = new DateTimeImmutable();
      $issuedAt       = $now->getTimestamp();
      $notBefore      = $now->modify($functionParams->jwtParams->notBefore)->getTimestamp();

      // 'sha512'
      $signer         = new Hmac();

      $expirationTime = $now->modify($functionParams->jwtParams->exp)->getTimestamp();

      // Builder object
      $builder = new Builder($signer);

      // Setup
      $builder
        ->setAudience($functionParams->jwtParams->aud)  // aud
        ->setContentType($functionParams->jwtParams->contentType)        // cty - header
        ->setExpirationTime($expirationTime)               // exp 
        ->setId($functionParams->jwtParams->prefixId . \uniqid())                    // JTI id 
        ->setIssuedAt($issuedAt)                      // iat 
        ->setIssuer($functionParams->jwtParams->iss)           // iss 
        ->setNotBefore($notBefore)                  // nbf
        ->setSubject($functionParams->jwtParams->sub)   // sub
        ->setPassphrase($functionParams->jwtParams->passphrase)                // password 
      ;

      // Phalcon\Encryption\Security\JWT\Token\Token
      $tokenObject = $builder->getToken();
      $token = $tokenObject->getToken();
      if (\property_exists($functionParams, 'redisFields')) {
        foreach ($functionParams->redisFields as $redisFieldsKey => $redisFieldsValue) {
          if ($redisFieldsKey == 'token') {
            $redis[$redisFieldsKey] = $token;
            $response[$redisFieldsKey] = $token;
          }
        }
        if (property_exists($functionParams, 'saveToRedis') && $functionParams->saveToRedis) {
          if (property_exists($functionParams, 'redisKey') && $functionParams->redisKey == 'token') {
            $this->aData['redisKey'] = $token;
          }
          if (isset($this->aData['redis'])) {
            $this->aData['redis'] = array_merge_recursive_distinct($this->aData['redis'], $redis);
          } else {
            $this->aData['redis'] = $redis;
          }
          $this->objRedis->set($this->aData['redisKey'], \json_encode($this->aData['redis']));
        }
      }
    }

    $this->aData['token'] = $token;
    return $token;
  }

  public function createAuthPdnd() {
  }

  public function logout($functionParams) {
    $finder = new Finder;
    $finder->aData = $this->aData;
    $finder->config = $this->config;
    $finder->configCsOrdini = $this->configCsOrdini;
    $this->objRedis->del($finder->findValue($functionParams->redisKey));
    $this->authorized = \false;
    return 'Logout!';
  }

  private function findUserFromDb(string $username, string $password) {
    $this->authorized = \false;
    $response['authorized'] = \false;
    $response['errors']['code'] = Response::STATUS_UNAUTHORIZED;
    $response['errors']['description'] = "Autenticazione fallita per l'utente $username";
  }

  private function findUserFromJson(string $username, string $password) {
    $this->authorized = \false;
    $response['authorized'] = \false;
    $response['errors']['code'] = Response::STATUS_UNAUTHORIZED;
    $response['errors']['description'] = "Autenticazione fallita per l'utente $username";
    $aUsers = \json_decode(\file_get_contents(\APP_PATH . '/../storage/demo/users.json'), \true);
    foreach ($aUsers['users'] as $user) {
      if ($user['username'] === $username && $user['password'] === $password) {
        unset($response['errors']);
        $response = ['authorized' => \true];
        $this->authorized = \true;
        break;
      }
    }
    return $response;
  }

  private function findUserFromLdap(string $username, string $password) {
    $this->authorized = \false;
    $response = [];
    // Connessione al server LDAP
    $ldapConn = ldap_connect($this->config->ldap->server, $this->config->ldap->port);
    if ($ldapConn) {
      // Imposta opzioni per la connessione LDAP
      ldap_set_option($ldapConn, LDAP_OPT_PROTOCOL_VERSION, 3);
      ldap_set_option($ldapConn, LDAP_OPT_REFERRALS, 0);

      // Autenticazione con il server LDAP
      $ldapBind = ldap_bind($ldapConn, 'cn=' . $this->config->ldap->user . ',' . $this->config->ldap->baseDn, $this->config->ldap->pass);
      if ($ldapBind) {
        // Ricerca dell'utente specificato per verifica delle credenziali
        $userDn = 'cn=' . $username . ',' . $this->config->ldap->baseDn;
        $userBind = ldap_bind($ldapConn, $userDn, $password);
        if ($userBind) {
          // echo "Autenticazione riuscita!";
          $response = ['authorized' => \true];
          $this->authorized = \true;
        } else {
          $response['errors']['code'] = Response::STATUS_UNAUTHORIZED;
          $response['errors']['description'] = "Autenticazione fallita per l'utente $username";
        }
      } else {
        $response['errors']['code'] = Response::STATUS_UNAUTHORIZED;
        $response['errors']['description'] = "Impossibile effettuare il binding con il server LDAP";
      }
      // Chiusura della connessione LDAP
      ldap_unbind($ldapConn);
    } else {
      $response['errors']['code'] = Response::STATUS_UNAUTHORIZED;
      $response['errors']['description'] = "Impossibile connettersi al server LDAP";
    }
    return $response;
  }
}
