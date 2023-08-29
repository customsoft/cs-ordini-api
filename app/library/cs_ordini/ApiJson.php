<?php

namespace cs_ordini;

use Exception;

class ApiJson extends \cs_ordini\_base {

  public function execute($params = null, $method = null) {
    $strApiJson = '';

    defined('DOMAIN') ? '' : define('DOMAIN', $_SERVER['SERVER_NAME']);
    defined('API_CONFIG') ? '' : define('API_CONFIG', 'cs-ordini');

    $pathConfig = \APP_PATH . '/config/api/' . API_CONFIG . '.json';
    $pathRefOpenApi = \APP_PATH . '/config/openapi/';
    if (file_exists($pathConfig)) {
      $config = json_decode(file_get_contents($pathConfig));
      if (property_exists($config, 'include')) {
        foreach ($config->include as $includePath) {
          if (substr($includePath, -5) == '.json') {
            try {
              header('If-Modified-Since: Mon, 26 Jul 1997 05:00:00 GMT');
              header('Cache-Control: no-cache');
              header('Pragma: no-cache');
              header('Content-Type: application/json');
              header('Content-Disposition: attachment; filename="' . API_CONFIG . '.json"');
              $regex = '/\{ "\$ref": "([a-z\-\/_]+.json)" \}/';
              $strApiJson =  preg_replace(
                '!\s+!',
                ' ',
                str_replace(
                  ["[[API_CONFIG]]", "[[DOMAIN]]", "\r\n", "\n"],
                  [API_CONFIG, DOMAIN, ' ', ' '],
                  file_get_contents(\APP_PATH . '/config/' . $includePath)
                )
              );
              preg_match_all($regex, $strApiJson, $matchs);
              foreach ($matchs[0] as $keyMatch => $match) {
                $jsonContent = '[]';
                if (\file_exists($pathRefOpenApi . $matchs[1][$keyMatch])) {
                  $jsonContent = file_get_contents($pathRefOpenApi . $matchs[1][$keyMatch]);
                }
                $strApiJson = str_replace($match, $jsonContent, $strApiJson);
              }
            } catch (Exception $exc) {
              echo $exc->getTraceAsString();
            }
          }
        }
      }
    } else {
      header("HTTP/1.0 404 Not Found");
    }
    return \json_decode($strApiJson, true);
  }
}
