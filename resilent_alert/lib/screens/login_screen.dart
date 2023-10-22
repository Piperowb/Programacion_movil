import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';
import 'registration_screen.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  Future<void> enviarSolicitudPost() async {
    final url = Uri.parse('http://192.168.1.3/webService/consultarUsuario.php'); // Reemplaza con la URL correcta

    final response = await http.post(
      url,
      body: {
        'correo': correoController.text,
        'contraseña': contrasenaController.text,
      },
    );
    
    if (response.statusCode == 200) {
      var responseData = response.body;
  
      if (responseData == 'array(0) {}') {
        mostrarAlerta("Los datos ingresados no son válidos, inténtalo nuevamente");
      } else {
        mostrarAlerta("Inicio de sesión exitoso");
        limpiarCampos();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      mostrarAlerta("Error al iniciar sesión");
    }
  }

  void mostrarAlerta(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void limpiarCampos() {
    correoController.clear();
    contrasenaController.clear();
  }

  void irARegistro() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        title: Text('Inicio de sesión'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Resilient Alert',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              TextField(
                controller: correoController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: contrasenaController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: enviarSolicitudPost,
                child: Text('Iniciar Sesión'),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              TextButton(
                onPressed: irARegistro,
                child: Text('¿No tienes cuenta? Regístrate', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
