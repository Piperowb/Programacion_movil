import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resilent_alert/screens/home_screen.dart';
import 'dart:convert';
import 'login_screen.dart';
import 'shelter.dart';
import 'type_disaster.dart';
import 'supply_list.dart';


class Alert {
  int id;
  String mensaje;
  String nombre;
  String ubicacion;
  String fecha;

  Alert({required this.id, required this.mensaje, required this.nombre, required this.ubicacion, required this.fecha});
}

class AlertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alertas',
      theme: ThemeData(
        primaryColor: Colors.red[900],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: AlertHomePage(),
    );
  }
}

class AlertHomePage extends StatefulWidget {
  @override
  _AlertHomePageState createState() => _AlertHomePageState();
}

class _AlertHomePageState extends State<AlertHomePage> {

  List<Alert> alerts = [];

  @override
  void initState() {
    super.initState();
    listarAlertas();
  }

  Future<void> listarAlertas() async {
    final url = Uri.parse('http://192.168.1.3/webService/listarAlertas.php');

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        alerts = data.map((item) => Alert(
          id: int.parse(item['id']),
          mensaje: item['mensaje'],
          nombre: item['nombre'],
          ubicacion: item['ubicacion'],
          fecha: item['fecha'],
        )).toList();
      });
    } else {
      mostrarAlerta("Error al listar alertas");
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
        title: Text('Alertas'),
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
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return Card(
              color: Colors.black,
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mensaje: ${alert.mensaje}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Tipo de desastre: ${alert.nombre}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Ubicación: ${alert.ubicacion}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Fecha: ${alert.fecha}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),

              ),
            );
          },
        ),
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
              leading: Icon(Icons.dashboard, color: Colors.red[900]),
              title: Text(
                'Refugios',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShelterScreen(),
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
              leading: Icon(Icons.view_list, color: Colors.red[900]),
              title: Text(
                'Suministros',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SupplyListScreen(),
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
