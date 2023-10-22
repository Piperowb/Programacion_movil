<?php

include_once 'config.php';

class conexion {

    function __construct() {
        
    }

    function conect() {

        $configdb = new configDb();
        $host = $configdb->getHost();
        $dbname = $configdb->getDbname();
        $user = $configdb->getUser();
        $pass = $configdb->getPass();


        error_reporting(E_ALL);
        ini_set('display_errors', '1');
        $pdo = new PDO("mysql:host=$host;port=3306;dbname=$dbname", $user, $pass);
      
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        return $pdo;
    }

}

?>