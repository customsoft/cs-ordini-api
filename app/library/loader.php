<?php

$loader = new \Phalcon\Autoload\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->setDirectories(
  [
    $config->application->controllersDir,
    $config->application->libraryDir,
    $config->application->libraryDir . '/cs_ordini',
    $config->application->modelsDir,
    $config->application->tasksDir
  ]
)->register();
