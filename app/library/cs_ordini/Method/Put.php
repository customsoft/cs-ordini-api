<?php

namespace cs_ordini\Method;

use Phalcon\Http\Response;

class Put extends \cs_ordini\_base {

  public function execute($params) {
    $action = '';
    $result = null;
    $this->aParams = \explode('/', $params);
    if (isset($this->aParams[0])) {
      $action = $this->aParams[0];
    }
    if ($action != '' && \property_exists($this->configCsOrdini->post->actions, $action)) {
      foreach ($this->configCsOrdini->post->actions->$action->class_functions as $class_function => $functionParams) {
        // \var_dump($class_function);
        // \var_dump($functionParams);
        // exit;
        if (property_exists($functionParams, 'authNeeded') && $functionParams->authNeeded) {
          $this->aData['error']['code'] = Response::STATUS_UNAUTHORIZED;
          $this->aData['error']['description'] = 'NotAuthorized: ' . $this->aParams;
        } else {
          list($class, $function) = \explode('_', $class_function);
          $fullClassName = '\\cs_ordini\\' . $class;
          $objAction = new $fullClassName();
          $objAction->aParams = $this->aParams;
          $objAction->config = $this->config;
          $objAction->configCsOrdini = $this->configCsOrdini;
          $result = $objAction->$function($functionParams);
          $this->evaluateResult($result, $functionParams);
        }
      }
      // Implementa qui la logica del metodo execute
      #$this->aData['result'] = "Risultato ottenuto da post::execute: " . \json_encode($this->aParams);
      $this->aData['result'] = $result;
    } else {
      $this->aData['error']['code'] = Response::STATUS_NOT_FOUND;
      $this->aData['error']['description'] = 'ActionNotExists: ' . json_encode($this->aParams);
    }
    return true;
  }

  /**
   * @param string $format: array, xml, json, ecc
   * 
   * @return null|mixed
   */
  public function result(string $format) {
    $result = null;
    // Implementa qui la logica del metodo execute
    switch (true) {
      case $format === 'array':
        $result = $this->aData;
        break;

      default:
        # code...
        break;
    }
    return $result;
  }
}
