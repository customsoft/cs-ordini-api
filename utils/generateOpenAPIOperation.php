<?php
require_once('_db.php');
$tables = [];


// Query per ottenere l'elenco delle tabelle
$sql = "SHOW TABLES";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  while ($row = $result->fetch_assoc()) {
    $table = $row["Tables_in_$dbname"];
    $fields = [];
    // Query per ottenere i nomi dei campi della tabella specificata
    $sql2 = "DESCRIBE $table";
    $result2 = $conn->query($sql2);

    if ($result2) {
      while ($row2 = $result2->fetch_assoc()) {
        $fields[$row2['Field']] = $row2;
      }
    } else {
      echo "Errore durante l'ottenimento dei nomi dei campi: " . $conn->error;
    }

    $tables[substr($table, 2, strlen($table))] = [
      "add" => ['operation' => 'add', 'method' => 'post', 'fields' => $fields],
      "get" => ['operation' => 'get', 'method' => 'get', 'fields' => $fields],
      "update" => ['operation' => 'update', 'method' => 'put', 'fields' => $fields],
      "delete" => ['operation' => 'delete', 'method' => 'delete', 'fields' => $fields],
      'list' => ['operation' => 'list', 'method' => 'get', 'fields' => $fields],
    ];
  }
} else {
  die("Nessuna tabella trovata nel database.");
}

// Chiusura della connessione
$conn->close();

// Cartella in cui verranno creati i file
$outputFolder = "../app/config/openapi/";

foreach ($tables as $table => $structures) {
  foreach ($structures as $structure) {
    $folder = explode("_", $table)[0];
    if (!is_dir($outputFolder . $folder)) {
      mkdir($outputFolder . $folder, 0770, true);
    }
    $filename = "$folder/{$table}-{$structure['operation']}.json";
    $filepath = $outputFolder . $filename;

    $data = generateOpenAPIOperation($table, $structure);

    file_put_contents($filepath, json_encode($data, JSON_PRETTY_PRINT));
    echo "$filename\n";
  }
}

function generateOpenAPIOperation($table, $structure) {
  // Personalizza questa funzione per generare i dati OpenAPI per ogni operazione
  $tableCamelCase = convertToCamelCase($table);
  $openAPIData = [
    "summary" => ucfirst($structure['operation']) . " " . $table,
    $structure['method'] => [
      'tags' => [$table],
      'security' => [['bearerAuth' => []]],
      'description' => 'Allow to ' . $structure['operation'] . ' a record ',
      'operationId' => $table . '-' . $structure['operation'],
      'responses' => [
        '200' => [
          'content' => [
            'application/json' => [
              'schema' => filterField($table, $structure['fields'], $structure['operation'], false)
              // '$ref' => '#/components/schemas/AssociateResponse'
            ]
          ]
        ],
        '401' => [
          'description' => 'Unauthorized: Access token is missing or invalid',
          'content' => [
            'application/json' => [
              'schema' => [
                '$ref' => '#/components/schemas/Errors'
              ]
            ]
          ]
        ]
      ]
    ],
  ];

  if ('post' === $structure['method'] || 'put' === $structure['method']) {
    $openAPIData[$structure['method']]['requestBody'] = [
      'content' => [
        'application/json' => [
          'schema' => filterField($table, $structure['fields'], $structure['operation'], true)
          // '$ref' => '#/components/schemas/' . $table . 'Request'
        ]
      ]
    ];
  } else {
    $openAPIData[$structure['method']]['parameters'] = [[
      'name' => $tableCamelCase . 'Id',
      'in' => 'path',
      'description' => $tableCamelCase . 'Id to get information.',
      'required' => true,
      'schema' => [
        "type=>integer"
      ]
    ]];
  }
  return $openAPIData;
}

function convertToCamelCase($input) {
  $parts = explode('_', $input);
  $camelCaseParts = array_map('ucfirst', $parts);
  return lcfirst(implode('', $camelCaseParts));
}

function filterField($tableName, $fields, $operation, $checkPrimary) {
  $result = [
    'type' => 'object',
    'properties' => []
  ];
  foreach ($fields as $key => $value) {
    switch (true) {
      case 'add' == $operation:
        if ($checkPrimary && 'PRI' == $value['Key']) {
          continue 2;
        }
        $result['properties'][$key] = ['type' => strpos($value['Type'], 'int') ? 'integer' : 'string'];
        break;
      case 'delete' == $operation:
        $result['properties'][$key] = ['type' => strpos($value['Type'], 'int') ? 'integer' : 'string'];
        break 2;
      case 'get' == $operation:
        $result['properties'][$key] = ['type' => strpos($value['Type'], 'int') ? 'integer' : 'string'];
        break;
      case 'update' == $operation:
        $result['properties'][$key] = ['type' => strpos($value['Type'], 'int') ? 'integer' : 'string'];
        break;
      case 'list' == $operation:
        if (!isset($result['properties'][$tableName]['type'])) {
          $result['properties'][$tableName]['type'] = 'array';
        }
        $result['properties'][$tableName]['items'][$key] = ['type' => strpos($value['Type'], 'int') ? 'integer' : 'string'];
        break;
      default:
        # code...
        break;
    }
  }
  return $result;
}
