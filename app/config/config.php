<?php

defined('BASE_PATH') || define('BASE_PATH', getenv('BASE_PATH') ?: realpath(dirname(__FILE__) . '/../..'));
defined('APP_PATH') || define('APP_PATH', BASE_PATH . '/app');
/*
 * const PUBLIC_PAGE:
 *
 * The list of public page list that does not require user authentication
 */
const PUBLIC_PAGE = array('index', 'login', 'logout', 'maintenance');

$aMarker = ['BASE_PATH', 'APP_PATH'];
$aReplacer = [BASE_PATH, APP_PATH];
$aConfig = json_decode(str_replace($aMarker, $aReplacer, file_get_contents(realpath(dirname(__FILE__)) . '/config.json')), true);

if (isset($aConfig['constants']) && isset($aConfig['constants']['required'])) {
  foreach ($aConfig['constants']['required'] as $value) {
    require_once APP_PATH . '/constants/' . $value;
  }
}

return new \Phalcon\Config\Config($aConfig);
