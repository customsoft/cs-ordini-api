<?php

declare(strict_types=1);

use Phalcon\Encryption\Crypt;
use Phalcon\Html\Escaper;
use Phalcon\Flash\Direct as Flash;
use Phalcon\Http\Response;
use Phalcon\Http\Response\Cookies;
use Phalcon\Logger\Adapter\Stream as FileLogger;
use Phalcon\Logger\Formatter\Line as FormatterLine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Php as PhpEngine;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Session\Adapter\Stream as SessionAdapter;
use Phalcon\Session\Manager as SessionManager;
use Phalcon\Mvc\Url as UrlResolver;


/**
 * Shared configuration service
 */
$di->setShared('serviceCheckConfig', function () {
  $objService = new \cs_ordini\CheckConfig();
  $objService->config = $this->getConfig();
  $objService->configCsOrdini = json_decode(file_get_contents(APP_PATH . '/config/api/cs-ordini.json'));
  $objService->objRedis = $this->getRedis();
  return $objService;

  return true;
});

/**
 * Shared configuration service
 */
$di->setShared('config', function () {
  return include APP_PATH . "/config/config.php";
});

/**
 * Set cookie universal
 */
$di->setShared('cookies', function () {
  $cookies = new Cookies();
  $cookies->useEncryption(true);
  return $cookies;
});

/**
 * Crypt service
 */
$di->setShared('crypt', function () {
  $config = $this->getConfig();

  $objCrypt = new Crypt();
  $objCrypt->setKey($config->app->cryptSalt);
  return $objCrypt;
});

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->setShared('db', function () {
  $config = $this->getConfig();

  $class = 'Phalcon\Db\Adapter\Pdo\\' . $config->database->adapter;
  $params = [
    'host'     => $config->database->host,
    'username' => $config->database->username,
    'password' => $config->database->password,
    'dbname'   => $config->database->dbname,
    'charset'  => $config->database->charset
  ];

  if ($config->database->adapter == 'Postgresql') {
    unset($params['charset']);
  }
  $connection = new $class($params);

  return $connection;
});

/**
 * Logger service
 */
$di->set('logger', function ($sFilename = null, $sFormat = null) {
  $config = $this->getConfig();
  $sFormat = $sFormat ?: $config->logger->format;
  $sFilename = trim($sFilename ?: $config->logger->filename, '\\/');
  $sPath = rtrim($config->logger->path, '\\/') . DIRECTORY_SEPARATOR;
  if (!is_dir($sPath)) {
    if (!mkdir($sPath, 0770, true)) {
      throw new Exception("Failed to create directories $sPath ...", 1);
    }
    chmod($sPath, 0770);
  }
  $objFormatter = new FormatterLine($sFormat, $config->logger->date);
  $objLogger = new FileLogger($sPath . $sFilename);

  $objLogger->setFormatter($objFormatter);

  return $objLogger;
});

/**
 * Start the redis the first time some component request the redis service
 */
$di->setShared('redis', function () {
  $redis = new \Redis();
  $config = $this->getConfig();
  $redis->connect($config->redis->host, $config->redis->port);
  if ($config->redis->auth) {
    #    $redis->auth(['username' => 'cs-ordini', 'password' => $config->redis->auth]);
    $redis->auth($config->redis->port);
  }
  return $redis;
});

/**
 * servizio per le API
 */
$di->setShared('serviceRequest', function () {
  $request = $this->getRequest();
  switch (true) {
    case $request->isPost():
    case $request->isPut():
      $objService = new \cs_ordini\Method\Post();
      break;
    case $request->isDelete():
    case $request->isGet():
      // echo "Altri metodi (es. PATCH, OPTIONS, ecc.)";
    default:
      $objService = new \cs_ordini\Method\Get();
      break;
  }
  $objService->config = $this->getConfig();
  $objService->configCsOrdini = json_decode(file_get_contents(APP_PATH . '/config/api/cs-ordini.json'));
  $objService->objRedis = $this->getRedis();
  return $objService;
});
/**
 * servizio per le API
 */
$di->setShared('serviceResponse', function ($data) {
  $response = new Response();
  $response->setContentType('application/json');
  $response->setJsonContent($data);
  return $response;
});

/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
  $session = new SessionManager();
  $files = new SessionAdapter([
    'savePath' => sys_get_temp_dir(),
  ]);
  $session->setAdapter($files);
  $session->start();

  return $session;
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
  $config = $this->getConfig();

  $url = new UrlResolver();
  $url->setBaseUri($config->application->baseUri);

  return $url;
});

/**
 * Setting up the view component
 */
$di->setShared('view', function () {
  $config = $this->getConfig();

  $view = new View();
  $view->setDI($this);
  $view->setViewsDir($config->application->viewsDir);

  $view->registerEngines([
    '.volt' => function ($view) {
      $config = $this->getConfig();

      $volt = new VoltEngine($view, $this);

      $volt->setOptions([
        'path' => $config->application->cacheDir,
        'separator' => '_'
      ]);

      return $volt;
    },
    '.phtml' => PhpEngine::class

  ]);

  return $view;
});

/**
 * Sets the view component
 */
$di->setShared('viewMicro', function () {
  $config = $this->getConfig();

  $view = new View();
  $view->setViewsDir($config->application->viewsDir);
  return $view;
});
