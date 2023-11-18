import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'shelter.dart';
import 'alerts.dart';
import 'type_disaster.dart';
import 'supply_list.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red[900],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController sugerenciasController = TextEditingController();
  List<Alert> alerts = []; // Lista para almacenar las alertas

  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar las alertas al inicio
    listarAlertas();
  }

  void irALogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> listarAlertas() async {
    final url = Uri.parse('http://192.168.1.3/webService/listarUltimaAlerta.php');

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        // Mapea los datos obtenidos a la lista de objetos Alert
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void mostrarAlerta(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje', style: TextStyle(fontWeight: FontWeight.bold)),
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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        title: Text('Resilient Alert'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: mostrarConfirmacionCerrarSesion,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar noticias recientes",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Icon(Icons.search, color: Colors.white),
              ],
            ),
          ),
          for (var alert in alerts)
            SectionCard(
              title: "Últimos movimientos",
              data: "Tipo de desastre: ${alert.nombre}\nUbicación: ${alert.ubicacion}\nFecha: ${alert.fecha}",
            ),
          SectionCard(
            title: "Pronóstico",
            data: "Estado: Tranquilo",
          ),
          SectionCard(
            title: "Sugerencias en pronóstico",
            data: TextField(
              controller: sugerenciasController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Ingresa tus sugerencias aquí',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AlertScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.flash_on, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TypeDisasterScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShelterScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.view_list, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SupplyListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Felipe Rodriguez"),
              accountEmail: Text("felipero@gmail.com"),
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
                mostrarAlerta("En proceso...");
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
                mostrarAlerta("En proceso...");
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

class SectionCard extends StatelessWidget {
  final String title;
  final dynamic data;

  SectionCard({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            _buildDataWidget(data), // Usa una función auxiliar para construir el widget
          ],
        ),
      ),
    );
  }

  Widget _buildDataWidget(dynamic data) {
    if (data is String) {
      return Text(
        data,
        style: TextStyle(color: Colors.white),
      );
    } else if (data is Widget) {
      return data;
    } else {
      return SizedBox.shrink(); // Devuelve un widget vacío si no es String ni Widget
    }
  }
}
