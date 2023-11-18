<?php

include 'CRUD/CRUD.php';

class EjemploPost {

    function __construct() {
        
    }

    function listarAlertas() {
        try {
            // Comprobar si la solicitud es POST
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                // Obtener los datos enviados en la solicitud POST
                
                $crud = new crud();
                $sql = "SELECT alerta.`id`, alerta.`mensaje`, alerta.`id_tipo_desastre`, alerta.`fecha`, alerta.`ubicacion`, tipo_desastre.`nombre`
                FROM `alerta`
                INNER JOIN `tipo_desastre` ON alerta.`id_tipo_desastre` = tipo_desastre.`id` ORDER BY id DESC LIMIT 1;
                ";
                
                $response = $crud ->consultar($sql);
                
                if (empty($response)) {
                    echo json_encode(0);
                } else {
                    echo json_encode($response);
                }
                    
            } else {
                // Si no es una solicitud POST, devolver un mensaje de error
                header('HTTP/1.1 405 Method Not Allowed');
                echo 'Método no permitido.';
            }
        } catch (PDOException $e) {
            $response = array(
                "success" => false,
                "message" => "Error: " . $e->getMessage()
            );
            
            // Devolver la respuesta en formato JSON en caso de error
            header('Content-Type: application/json');
            echo json_encode($response);
        }
    }
}

// Crear una instancia de la clase 'crud'

$ejemploPost = new EjemploPost();

// Llamar a la función 'insertarUsuario' para manejar la solicitud POST
$ejemploPost->listarAlertas();