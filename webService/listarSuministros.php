<?php

include 'CRUD/CRUD.php';

class EjemploPost {

    function __construct() {
        
    }

    function listarSuministros() {
        try {
            // Comprobar si la solicitud es POST
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                // Obtener los datos enviados en la solicitud POST
                
                $crud = new crud();
                $sql = "SELECT lista_suministros.id, tipo_desastre.id AS id_tipo_desastre, 
                        tipo_desastre.nombre, tipo_desastre.descripcion, tipo_desastre.ubicacion, 
                        lista_suministros.suministro, lista_suministros.descripcion AS descripcion_suministro
                        FROM lista_suministros
                        INNER JOIN tipo_desastre ON lista_suministros.id_tipo_desastre = tipo_desastre.id ORDER BY id DESC;
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
$ejemploPost->listarSuministros();