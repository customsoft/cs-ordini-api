<?php

namespace cs_ordini;


class Finder extends \cs_ordini\_base {

  // public function findValue($params = null, $method = null) {
  //   return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImN0eSI6ImFwcGxpY2F0aW9uL2pzb24ifQ.eyJhdWQiOlsiY3Mtb3JkaW5pIl0sImV4cCI6MTY5MjQ2NDY5NCwianRpIjoiY3Mtb3JkaW5pXzY0ZGZhNGI2NmMyZDQiLCJpYXQiOjE2OTIzNzgyOTQsImlzcyI6ImN1c3RvbXNvZnQiLCJuYmYiOjE2OTIzNzgyMzQsInN1YiI6ImN1c3RvbXNvZnQifQ.K9zt2X-tdpeSTfovybi1NBVef_VN-b9d-q6k4bcg9mCtyiVM0pEHJthlZ2uQEevOjPQaTJsorh45CoD_Kw3JGQ";
  // }


  /**
   * Recupera il valore in base alla chiave passata
   *
   * @param string|array|object $key
   *
   * @return mixed
   */
  public function findValue($key) {
    $result = $key;
    if (is_numeric($result) || is_bool($result)) {
    } elseif (is_string($result)) {
      preg_match_all('/\b(config|redis|source)(?:[^\/\s]*_\._[^\/\s]*)\b/', $result, $matchs);
      foreach ($matchs[0] as $valueMatch) {
        $result = str_replace($valueMatch, $this->subFindValue($valueMatch), $result);
      }
    } else {
      foreach ($result as $subKey => $value) {
        if (is_array($result)) {
          $result[$subKey] = $this->findValue($value);
        } else {
          $result->$subKey = $this->findValue($value);
        }
      }
    }
    return $result;
  }

  private function subFindValue($key) {
    $result = $key;
    $aKey = \explode('_._', $key);
    $tmpData = $this->aData;
    foreach ($aKey as $value) {
      if (substr($value, -2) == '[]') {
        $value = substr($value, 0, strlen($value) - 2);
        if (!is_null($tmpData) && isset($tmpData[$value]) && isset($tmpData[$value][0])) {
          $tmpData2 = $tmpData;
          $tmpData = [];
          foreach ($tmpData2[$value] as $keyTmpDataValue => $valueTmpDataValue) {
            $tmpData[$keyTmpDataValue] = $valueTmpDataValue;
          }
          if (is_string($tmpData) || is_numeric($tmpData) || is_array($tmpData)) {
            $result = $tmpData;
          }
        } else {
          $result = '';
          break;
        }
      } else {
        if (isset($tmpData[$value])) {
          $tmpData = $tmpData[$value];
          if (is_string($tmpData) || is_numeric($tmpData) || is_array($tmpData)) {
            $result = $tmpData;
          }
        } else if (is_numeric(array_key_first($tmpData)) && isset($tmpData[array_key_first($tmpData)][$value])) {
          foreach ($tmpData as $tmpDataKey2 => $tmpDataValue2) {
            $result[$tmpDataKey2] = $tmpDataValue2[$value];
          }
        } else {
          $result = '';
          break;
        }
      }
    }

    return $result;
  }
}
