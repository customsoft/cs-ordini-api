<?php

namespace cs_ordini;

use Phalcon\Http\Response;

class _base {
  /**
   * 
   */
  protected array $aData = [];
  protected string $action = '';
  public array $aParams = [];
  public object $config;
  public object $configCsOrdini;
  public object $objRedis;
  public $authorized = false;

  /**
   * @param string $params: login, logout, ecc
   * 
   * @return null|bool
   */
  public function execute($params, $method) {
    $this->aData['config'] = json_decode(json_encode($this->configCsOrdini), true);
    foreach ($this->configCsOrdini->$method->actions->{$this->action}->class_functions as $class_function => $functionParams) {
      if (property_exists($functionParams, 'authNeeded') && $functionParams->authNeeded && !$this->authorized) {
        $this->aData['error']['code'] = Response::STATUS_UNAUTHORIZED;
        $this->aData['error']['description'] = 'NotAuthorized: ' . $this->action;
      } else {
        if ('shared_class_functions' !== $class_function) {
          list($class, $function) = \explode('_', $class_function);
        } else {
          list($class, $function) = \explode('_', $functionParams);
          $functionParams = $this->configCsOrdini->shared_class_functions->$functionParams;
        }
        $fullClassName = '\\cs_ordini\\' . $class;
        $objAction = new $fullClassName();
        $objAction->aData = $this->aData;
        $objAction->aParams = $this->aParams;
        $objAction->config = $this->config;
        $objAction->configCsOrdini = $this->configCsOrdini;
        $objAction->objRedis = $this->objRedis;
        $result = $objAction->$function($functionParams);
        $this->evaluateResult($result, $functionParams);
      }
    }
    $this->aData['result'] = $result;
  }

  /**
   * @param string $format: array, json, json-base64, xml, ecc
   * 
   * @return null|mixed
   */
  public function result(string $format) {
    $result = null;
    $tmpData = $this->aData;
    unset($tmpData['config']);
    unset($tmpData['redis']);
    unset($tmpData['source']);
    switch (true) {
      case $format === 'array':
        $result = $tmpData;
        break;
      case $format === 'json':
        $result = json_encode($tmpData);
        break;
      case $format === 'json-base64':
        $result = base64_encode(json_encode($tmpData));
        break;
      case $format === 'xml':
        $result = array_to_xml($tmpData);
        break;
      default:
        $result = $tmpData;
        break;
    }
    return $result;
  }


  /**
   * 
   */
  protected function evaluateResult($result, $functionParams) {
  }
}
