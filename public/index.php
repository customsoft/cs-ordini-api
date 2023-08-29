<?php

declare(strict_types=1);

use Phalcon\Di\FactoryDefault;
use Phalcon\Mvc\Micro;

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');

/**
 * Set DEBUG status.
 */
if (!defined('DEBUG') &&  file_exists(APP_PATH . '/debug.php') && file_get_contents(APP_PATH . '/debug.php') == 'true') {
  #echo "DEBUG ON" . PHP_EOL;
  define('DEBUG', true);
} else {
  #  define('DEBUG', false);
}

/**
 * Enable display errors.
 */
define('ERROR_LOG', BASE_PATH . '/logs/telegram.log');
if (DEBUG) {
  /**
   * SET ERROR REPORTING: REMOVE ON PRODUCTION!
   */
  #$error_log = BASE_PATH . '/logs/telegram.log';
  error_reporting(E_ALL);
  ini_set('display_errors', 'On');
  ini_set('log_errors', 'On');
  ini_set('error_log', ERROR_LOG);
}

try {
  /**
   * The FactoryDefault Dependency Injector automatically registers the services that
   * provide a full stack framework. These default services can be overidden with custom ones.
   */
  $di = new FactoryDefault();

  /**
   * Include Services
   */
  include APP_PATH . '/library/services.php';

  /**
   * Get config service for use in inline setup below
   */
  $config = $di->getConfig();

  /**
   * Include Autoloader
   */
  include APP_PATH . '/library/loader.php';

  /**
   * Starting the application
   * Assign service locator to the application
   */
  $app = new Micro($di);

  /**
   * Include Application
   */
  include APP_PATH . '/micro/app-micro.php';

  /**
   * Handle the request
   */
  $app->handle($_SERVER['REQUEST_URI']);
} catch (\Exception $e) {
  echo $e->getMessage() . '<br>';
  echo '<pre>' . $e->getTraceAsString() . '</pre>';
}
