<?php

include 'CRUD/CRUD.php';

class EjemploPost {

    function __construct() {
        
    }

    function agregarRefugios() {
        try {
            // Comprobar si la solicitud es POST
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                // Obtener los datos enviados en la solicitud POST
                $nombre = $_POST['nombre'];
                $ubicacion = $_POST['ubicacion'];
                $capacidad = $_POST['capacidad'];
                $servicios = $_POST['servicios'];
                
                $crud = new crud();
                $sql = "INSERT INTO refugio (nombre, ubicacion, capacidad, servicios) VALUES ('$nombre', '$ubicacion', $capacidad, '$servicios');";
                
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
$ejemploPost->agregarRefugios();