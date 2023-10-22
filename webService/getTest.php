<?php

include 'CRUD/CRUD.php';

class gettest {

    function __construct() {
        
    }

    function consultar_test() {

        $crud = new crud();

        $resp = $crud->consultar("select * from usuario;");
        header('Content-Type: application/json');
        echo json_encode($resp);
        
        
//        foreach ($resp as $row) {
//            print($row->str_nombres);
//            print($row->str_apellidos);
//            print "<br />";
//        }
    }

}

$getest = new gettest();
$getest->consultar_test();
?>