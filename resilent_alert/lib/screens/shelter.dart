import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resilent_alert/screens/home_screen.dart';
import 'dart:convert';
import 'login_screen.dart';
import 'alerts.dart';
import 'type_disaster.dart';

class Shelter {
  int id;
  String nombre;
  String ubicacion;
  int capacidad;
  String servicios;

  Shelter({required this.id, required this.nombre, required this.ubicacion, required this.capacidad, required this.servicios});
}

class ShelterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refugios',
      theme: ThemeData(
        primaryColor: Colors.red[900],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: ShelterHomePage(),
    );
  }
}

class ShelterHomePage extends StatefulWidget {
  @override
  _ShelterHomePageState createState() => _ShelterHomePageState();
}

class _ShelterHomePageState extends State<ShelterHomePage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController capacidadController = TextEditingController();
  final TextEditingController serviciosController = TextEditingController();

  List<Shelter> shelters = [];

  @override
  void initState() {
    super.initState();
    listarRefugios(); // Al cargar la página, lista los refugios
  }

  Future<void> listarRefugios() async {
    final url = Uri.parse('http://192.168.1.3/webService/listarRefugios.php');

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        shelters = data.map((item) => Shelter(
          id: int.parse(item['id']),
          nombre: item['nombre'],
          ubicacion: item['ubicacion'],
          capacidad: int.parse(item['capacidad']),
          servicios: item['servicios'],
        )).toList();
      });
    } else {
      mostrarAlerta("Error al listar refugios");
    }
  }

  Future<void> agregarRefugio() async {
    final url = Uri.parse('http://192.168.1.3/webService/agregarRefugio.php');

    final response = await http.post(
      url,
      body: {
        'nombre': nombreController.text,
        'ubicacion': ubicacionController.text,
        'capacidad': capacidadController.text,
        'servicios': serviciosController.text,
      },
    );

    if (response.statusCode == 200) {
      mostrarAlerta("Refugio agregado exitosamente");
      limpiarCampos();
      listarRefugios();
    } else {
      mostrarAlerta("Error al agregar refugio");
    }
  }

  Future<void> eliminarRefugio(int id) async {
    final url = Uri.parse('http://192.168.1.3/webService/eliminarRefugio.php');

    final response = await http.post(
      url,
      body: {
        'id': id.toString(),
      },
    );

    if (response.statusCode == 200) {
      mostrarAlerta("Refugio eliminado exitosamente");
      listarRefugios();
    } else {
      mostrarAlerta("Error al eliminar refugio");
    }
  }

  void mostrarAlerta(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(mensaje, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  void limpiarCampos() {
    nombreController.clear();
    ubicacionController.clear();
    capacidadController.clear();
    serviciosController.clear();
  }

  void agregarRefugioModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Refugio', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Refugio',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: ubicacionController,
                decoration: InputDecoration(
                  labelText: 'Ubicación del Refugio',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: capacidadController,
                decoration: InputDecoration(
                  labelText: 'Capacidad del Refugio',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: serviciosController,
                decoration: InputDecoration(
                  labelText: 'Servicios del Refugio',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                agregarRefugio();
              },
              child: Text('Guardar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
          ],
        );
      },
    );
  }

  Future<void> mostrarConfirmacionCerrarSesion() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar Sesión', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('¿Está seguro de que desea cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red[900]),
              child: Text('Confirmar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                cerrarSesion();
              },
            ),
          ],
        );
      },
    );
  }

  void cerrarSesion() {
    // Puedes agregar la lógica para cerrar la sesión, por ejemplo, navegar a la pantalla de inicio de sesión.
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refugios'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              mostrarConfirmacionCerrarSesion();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.red[900],
        child: ListView.builder(
          itemCount: shelters.length,
          itemBuilder: (context, index) {
            final shelter = shelters[index];
            return Card(
              color: Colors.black,
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${shelter.nombre}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Ubicación: ${shelter.ubicacion}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Capacidad: ${shelter.capacidad}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Servicios: ${shelter.servicios}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    eliminarRefugio(shelter.id);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarRefugioModal,
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Felipe Rodriguez"),
              accountEmail: Text("felipero@gmial.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.red[900],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.red[900]),
              title: Text(
                'Inicio',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
                
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.red[900]),
              title: Text(
                'Alertas',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AlertScreen(),
                ),
              );
                
              },
            ),
            ListTile(
              leading: Icon(Icons.flash_on, color: Colors.red[900]),
              title: Text(
                'Tipos de desastres',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TypeDisasterScreen(),
                ),
              );
                
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.red[900]),
              title: Text(
                'Configuración',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info, color: Colors.red[900]),
              title: Text(
                'Acerca de',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red[900]),
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: mostrarConfirmacionCerrarSesion,
            ),
          ],
        ),
      ),
    );
  }
}
