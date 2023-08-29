<?php

/**
 * Unisce array o oggetti in modo recursivo sovrascrivendo i dati
 * Restituisce sempre un array
 *
 * @param array|object $array1
 * @param array|object $array2
 *
 * @return array
 */
function array_merge_recursive_distinct($array1, $array2) {
  if (!is_object($array1)) {
    $array1 = (array)$array1;
  } elseif (!is_array($array1)) {
    $array1 = [];
  }
  if (!is_object($array2)) {
    $array2 = (array)$array2;
  } elseif (!is_array($array2)) {
    $array2 = [];
  }

  foreach ($array2 as $key => $value) {
    if (is_object($value)) {
      $value = (array)$value;
    }
    if (isset($array1[$key]) && is_object($array1[$key])) {
      $array1[$key] = (array)$array1[$key];
    }
    if (is_array($value) && isset($array1[$key]) && (is_array($array1[$key]) || is_object($array1[$key]))) {
      $array1[$key] = array_merge_recursive_distinct((array)$array1[$key], $value);
    } else {
      $array1[$key] = $value;
    }
  }

  return $array1;
}

function array_to_xml($array, $xml = null) {
  if ($xml === null) {
    $xml = new SimpleXMLElement('<root/>');
  }

  foreach ($array as $key => $value) {
    if (is_array($value)) {
      array_to_xml($value, $xml->addChild($key));
    } else {
      $xml->addChild($key, htmlspecialchars($value));
    }
  }

  return $xml->asXML();
}
