<?php
require_once('../app/config/config.php');


$host = $aConfig['database']['host'];
$username = $aConfig['database']['username'];
$password = $aConfig['database']['password'];
$dbname = $aConfig['database']['dbname'];

// Connessione al database
$conn = new mysqli($host, $username, $password, $dbname);

// Verifica della connessione
if ($conn->connect_error) {
  die("Connessione fallita: " . $conn->connect_error);
}
