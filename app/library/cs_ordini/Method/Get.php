<?php

namespace cs_ordini\Method;

use Phalcon\Http\Response;

class Get extends \cs_ordini\_base {

  public function execute($params, $method) {
    $result = null;
    $this->aParams = \explode('/', $params);
    if (isset($this->aParams[0])) {
      $this->action = $this->aParams[0];
      array_shift($this->aParams);
    }
    $this->aData['source'] = $this->aParams;
    if ($this->action != '' && \property_exists($this->configCsOrdini->$method->actions, $this->action)) {
      // foreach ($this->configCsOrdini->get->actions->{$this->action}->class_functions as $class_function => $functionParams) {
      //   if (property_exists($functionParams, 'authNeeded') && $functionParams->authNeeded && !$this->authorized) {
      //     $this->aData['error']['code'] = Response::STATUS_UNAUTHORIZED;
      //     $this->aData['error']['description'] = 'NotAuthorized: ' . $this->action;
      //   } else {
      //     list($class, $function) = \explode('_', $class_function);
      //     $fullClassName = '\\cs_ordini\\' . $class;
      //     $objAction = new $fullClassName();
      //     $objAction->aParams = $this->aParams;
      //     $objAction->config = $this->config;
      //     $objAction->configCsOrdini = $this->configCsOrdini;
      //     $result = $objAction->$function($functionParams);
      //     $this->evaluateResult($result, $functionParams);
      //   }
      // }
      // $this->aData['result'] = $result;
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
}
