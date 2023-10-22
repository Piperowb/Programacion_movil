import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

void main() {
  runApp(RegistrationScreen());
}

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de usuario',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  Future<void> enviarSolicitudPost() async {
    final url = Uri.parse('http://192.168.1.3/webService/insertarUsuario.php'); // Reemplaza con la URL correcta

    final response = await http.post(
      url,
      body: {
        'nombre': nombreController.text,
        'contraseña': contrasenaController.text,
        'correo': correoController.text,
        'direccion': direccionController.text,
        'telefono': telefonoController.text,
      },
    );

    if (response.statusCode == 200) {
      // La solicitud se realizó con éxito
      final responseData = response.body;
      print(responseData); // Puedes procesar la respuesta aquí
      mostrarAlerta("Registro exitoso");
      limpiarCampos();

      // Redirige a la pantalla de inicio de sesión
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      // Hubo un error en la solicitud
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      mostrarAlerta("Error al enviar los datos");
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
    nombreController.clear();
    contrasenaController.clear();
    correoController.clear();
    direccionController.clear();
    telefonoController.clear();
  }

  void irALogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
            children: <Widget>[
              Text(
                'Registro de usuario',
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
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person, color: Colors.white), // Color del ícono
                  labelStyle: TextStyle(color: Colors.white), // Color de la etiqueta
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Bordes blancos al enfocar
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: correoController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email, color: Colors.white), // Color del ícono
                  labelStyle: TextStyle(color: Colors.white), // Color de la etiqueta
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Bordes blancos al enfocar
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: contrasenaController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock, color: Colors.white), // Color del ícono
                  labelStyle: TextStyle(color: Colors.white), // Color de la etiqueta
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Bordes blancos al enfocar
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: direccionController,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  prefixIcon: Icon(Icons.location_on, color: Colors.white), // Color del ícono
                  labelStyle: TextStyle(color: Colors.white), // Color de la etiqueta
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Bordes blancos al enfocar
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: telefonoController,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: Icon(Icons.phone, color: Colors.white), // Color del ícono
                  labelStyle: TextStyle(color: Colors.white), // Color de la etiqueta
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Bordes blancos al enfocar
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: enviarSolicitudPost,
                child: Text('Registrarse'),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              TextButton(
                onPressed: irALogin,
                child: Text('¿Ya tienes una cuenta? Inicia Sesión', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
