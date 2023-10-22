import 'package:flutter/material.dart';
import 'login_screen.dart';

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
  void irALogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
            onPressed: irALogin,
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
                      hintText: "Buscar alertas",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Icon(Icons.person, color: Colors.white),
              ],
            ),
          ),
          SectionCard(
            title: "Últimos movimientos",
            data: "Sismo 4.6\nValle del Cauca\n25 Ago, 10 am",
          ),
          SectionCard(
            title: "Pronósticos y alertas",
            data: "Estado: Tranquilo\n---\n---",
          ),
          SectionCard(
            title: "Sugerencias en pronóstico",
            data: "Tus sugerencias aquí",
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
                // Acción para mostrar notificaciones
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on, color: Colors.white),
              onPressed: () {
                // Acción para mostrar notificaciones
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Usuario"),
              accountEmail: Text("usuario@correo.com"), //Traer de la base de datos una vez logueado
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black, // Fondo negro
                child: Icon(Icons.person, size: 50, color: Colors.white), // Icono de color blanco
              ),
              decoration: BoxDecoration(
                color: Colors.red[900],
              ),
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
                // Acción para tablero
                Navigator.pop(context);
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
                // Acción para configuración
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
                // Acción para "Acerca de"
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
              onTap: irALogin,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String data;

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
            Text(
              data,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
