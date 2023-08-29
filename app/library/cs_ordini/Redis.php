<?php

namespace cs_ordini;

class Redis extends \cs_ordini\_base {

  public function readData($params) {
    $result = [];
    // $params = ['loginStatus', 'pages'];
    // [
    //   'loginStatus' => 'loginOk'
    //   'pages'=>[
    //     $this->aData['']
    //   ]
    // ]
    foreach ($params['data'] as $value) {
      $result[$value] = $this->aData['redis'][$value];
    }
    $result = [
      'loginStatus' => 'loginOk',
      'pages' => [
        'dashboard' => 'Bacheca',
      ],
      'userData' => ['username' => 'Marco',],
    ];
    return $result;
  }
}
