<?php

use Phalcon\Http\Response;

/**
 * Local variables
 * @var \Phalcon\Mvc\Micro $app
 */

/**
 * Add your routes here
 */

$app->delete('/{param1}/{param2}', function ($param1, $param2 = null) use ($app) {
  $service = $app['serviceRequest'];
  $service->execute($param1 . '/' . $param2, 'delete');
  return $app->di->get('serviceResponse', $service->result('array'));
});

$app->delete('/{params}', function ($params) use ($app) {
  $service = $app['serviceRequest'];
  $service->execute($params, 'delete');
  return $app->di->get('serviceResponse', $service->result('array'));
});

$app->get('/{param1}/{param2}', function ($param1, $param2 = null) use ($app) {
  $service = $app['serviceRequest'];
  $service->execute($param1 . '/' . $param2, 'get');
  return $app->di->get('serviceResponse', $service->result('array'));
});

$app->get('/{params}', function ($params) use ($app) {
  $service = $app['serviceRequest'];
  $service->execute($params, 'get');
  return $app->di->get('serviceResponse', $service->result('array'));
});

$app->get('/', function () use ($app) {
  $service = $app['serviceCheckConfig'];
  $service->execute();
  return $app->di->get('serviceResponse', $service->result('array'));
});

$app->post('/{params}', function ($params) use ($app) {
  $service = $app['serviceRequest'];
  $service->execute($params, 'post');
  return $app->di->get('serviceResponse', $service->result('array'));
});

$app->put('/{$params}', function ($params) use ($app) {
  $service = $app['serviceRequest'];
  $service->execute($params, 'put');
  return $app->di->get('serviceResponse', $service->result('array'));
});

/**
 * Not found handler
 */
$app->notFound(function () use ($app) {
  $app->response->setStatusCode(404, "Not Found")->sendHeaders();
  return $app->di->get('serviceResponse', [[400 => 'NotFound']]);
});
/**
Fatal error:  Uncaught ArgumentCountError: Too few arguments to function Closure::{closure}(), 0 passed and exactly 1 expected in /home/alan/csOrdini/cs-ordini-api/app/library/services.php:73
Stack trace:
#0 [internal function]: Closure->{closure}()
#1 [internal function]: Phalcon\\Di\\Service->resolve()
#2 [internal function]: Phalcon\\Di\\Di->get()
#3 [internal function]: Phalcon\\Mvc\\Micro->getService()
#4 /home/alan/csOrdini/cs-ordini-api/app/micro/app-micro.php(13): Phalcon\\Mvc\\Micro->offsetGet()
#5 [internal function]: Closure->{closure}()
#6 /home/alan/csOrdini/cs-ordini-api/public/index.php(72): Phalcon\\Mvc\\Micro->handle()
#7 {main}
  thrown in /home/alan/csOrdini/cs-ordini-api/app/library/services.php on line 73 
  

curl -X 'DELETE' 'https://u001.marcozordan.it/deleteUser' -H 'accept: application/json'

 */
