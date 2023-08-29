<?php

declare(strict_types=1);

class VersionTask extends \Phalcon\Cli\Task {
  public function mainAction() {
    $config = $this->getDI()->get('config');

    echo 'Version: ' . $config['version'] . PHP_EOL;
  }
}
