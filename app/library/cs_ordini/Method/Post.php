<?php

namespace cs_ordini\Method;

use Phalcon\Http\Response;

class Post extends \cs_ordini\_base {

  public function execute($params, $method) {
    $result = null;
    $this->aParams = \explode('/', $params);
    if (isset($this->aParams[0])) {
      $this->action = $this->aParams[0];
      array_shift($this->aParams);
    }
    $this->aParams = $this->readPost();
    $allowedEmptyPost = false;
    if (
      \property_exists($this->configCsOrdini->$method->actions, $this->action) &&
      \property_exists($this->configCsOrdini->$method->actions->{$this->action}, 'allowedEmptyPost')
    ) {
      $allowedEmptyPost = $this->configCsOrdini->$method->actions->{$this->action}->allowedEmptyPost;
    }
    if (!\is_array($this->aParams) || ($this->aParams == [] && false === $allowedEmptyPost)) {
      $this->aData['error']['code'] = Response::STATUS_BAD_REQUEST;
      $this->aData['error']['description'] = 'PostMissing!';
    } elseif ($this->action != '' && \property_exists($this->configCsOrdini->$method->actions, $this->action)) {
      $this->aData['source'] = $this->aParams;
      parent::execute($params, $method);
    } else {
      $this->aData['error']['code'] = Response::STATUS_NOT_FOUND;
      $this->aData['error']['description'] = 'ActionNotExists: ' . $this->action;
    }
    return true;
  }

  protected function evaluateResult($result, $functionParams) {
    if (isset($result['authorized'])) {
      $this->authorized = $result['authorized'];
    }
  }

  /**
   * Legge i dati inviati tramite una richiesta POST.
   *
   * Questa funzione tenta di leggere i dati dal superglobale $_POST. Se i dati non sono presenti
   * o sono vuoti, tenta di leggere il corpo della richiesta HTTP direttamente. Inoltre, se il
   * contenuto dei dati non può essere decodificato come array JSON, restituisce una stringa vuota.
   *
   * @return array Un array contenente i dati POST oppure un array vuoto in caso di errori.
   */
  private function readPost() {
    $post = $_POST;
    if ((!is_array($post) && (trim('' . $post)) === '') || (is_array($post) && $post == [])) {
      $post = json_decode(file_get_contents("php://input"), true);
      if ((!is_array($post) && (trim('' . $post)) === '') || (is_array($post) && $post == [])) {
        /**
         * Missing content-lenght in header
         * https://splunktool.com/how-to-capture-full-http-request-data-headers-and-body-with-php
         * Solution 4: How to capture full HTTP request data (headers and body) with PHP?
         */
        $post = '';
        $fh = @fopen('php://input', 'r');
        if ($fh) {
          while (!feof($fh)) {
            $s = fread($fh, 1024);
            if (is_string($s)) {
              $post .= $s;
            }
          }
          fclose($fh);
        }
        $post = \json_decode($post, true);
      }
    }
    if (!\is_array($post)) {
      $post = [];
    }
    return $post;
  }
}
