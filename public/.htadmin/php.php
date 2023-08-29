<?php

if (file_exists(APP_PATH . 'debug.php') && file_get_contents(APP_PATH . 'debug.php') == 'true') {
  echo "DEBUG ON";
  define('DEBUG', true);
} else {
  define('DEBUG', false);
}

/**
 * Enable display errors.
 */
define('ERROR_LOG', BASE_PATH . '/logs/cs-ordini-api.log');
if (DEBUG) {
  /**
   * SET ERROR REPORTING: REMOVE ON PRODUCTION!
   */
  #$error_log = BASE_PATH . '/logs/telegram.log';
  error_reporting(E_ALL);
  ini_set('display_errors', 'On');
  ini_set('log_errors', 'On');
  ini_set('error_log', ERROR_LOG);

  phpinfo();
}
