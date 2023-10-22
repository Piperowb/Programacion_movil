<?php

include 'CRUD/CRUD.php';

class EjemploPost {

    function __construct() {
        
    }

    function consultar($sql) {
        $conexion = new conexion();
        $pdo = $conexion->conect();
        $sql = $pdo->prepare($sql);
        $results = $sql->execute();
        $rows = $sql->fetchAll(\PDO::FETCH_OBJ);
        
        return $rows;
    }

    function insertarUsuario() {
        try {
            // Comprobar si la solicitud es POST
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                // Obtener los datos enviados en la solicitud POST
                $nombre = $_POST['nombre'];
                $contraseña = $_POST['contraseña'];
                $correo = $_POST['correo'];
                $direccion = $_POST['direccion'];
                $telefono = $_POST['telefono'];
                $fechaDateTime = new DateTime();
                $dataTime = $fechaDateTime->format('Y-m-d H:i:s');
                
                $crud = new crud();
                $sql = "INSERT INTO usuario (nombre, contraseña, correo, direccion, telefono, fecha_creacion) VALUES ('$nombre', '$contraseña', '$correo', '$direccion', $telefono, '$dataTime')";
                
                $response =  $crud ->insertar($sql);
    
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
$ejemploPost->insertarUsuario();