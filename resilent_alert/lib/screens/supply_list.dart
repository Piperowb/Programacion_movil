import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resilent_alert/screens/home_screen.dart';
import 'dart:convert';
import 'login_screen.dart';
import 'alerts.dart';
import 'shelter.dart';
import 'type_disaster.dart';

class SupplyList {
  int id;
  String nombre;
  String descripcion;
  String tipo_desastre;

  SupplyList({required this.id, required this.nombre, required this.descripcion, required this.tipo_desastre});
}

class TypeDisaster {
  int id;
  String nombre;
  String descripcion;
  String ubicacion;

  TypeDisaster({required this.id, required this.nombre, required this.descripcion, required this.ubicacion});
}

class SupplyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de suministros',
      theme: ThemeData(
        primaryColor: Colors.red[900],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: SupplyListHomePage(),
    );
  }
}

class SupplyListHomePage extends StatefulWidget {
  @override
  _SupplyListHomePageState createState() => _SupplyListHomePageState();
}

class _SupplyListHomePageState extends State<SupplyListHomePage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController tipo_desastreController = TextEditingController();

  TypeDisaster? selectedTipoDesastre;

  List<SupplyList> SupplyLists = [];
  List<TypeDisaster> TypeDisasters = [];

  @override
  void initState() {
    super.initState();
    listarSuministro();
    listarDesastre();
  }

  Future<void> listarSuministro() async {
    final url = Uri.parse('http://192.168.1.3/webService/listarSuministros.php');

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        SupplyLists = data.map((item) => SupplyList(
          id: int.parse(item['id']),
          nombre: item['suministro'],
          descripcion: item['descripcion_suministro'],
          tipo_desastre: item['nombre'],
        )).toList();
      });
    } else {
      mostrarAlerta("Error al listar suministros");
    }
  }

  Future<List<TypeDisaster>> listarDesastre() async {
  final url = Uri.parse('http://192.168.1.3/webService/listarDesastres.php');

  final response = await http.post(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    return data.map((item) => TypeDisaster(
      id: int.parse(item['id']),
      nombre: item['nombre'],
      descripcion: item['descripcion'],
      ubicacion: item['ubicacion'],
    )).toList();
  } else {
    mostrarAlerta("Error al listar tipos de desastres");
    throw Exception("Error al obtener la lista de tipos de desastre");
  }
}


  Future<void> agregarSuministro() async {
    final url = Uri.parse('http://192.168.1.3/webService/agregarSuministro.php');

    final response = await http.post(
      url,
      body: {
        'nombre': nombreController.text,
        'descripcion': descripcionController.text,
        'tipo_desastre': selectedTipoDesastre?.id.toString() ?? '',
      },
    );

    if (response.statusCode == 200) {
      mostrarAlerta("Suministro agregado exitosamente");
      limpiarCampos();
      listarSuministro();
    } else {
      mostrarAlerta("Error al agregar suministro");
    }
  }

  Future<void> eliminarSuministro(int id) async {
    final url = Uri.parse('http://192.168.1.3/webService/eliminarSuministro.php');

    final response = await http.post(
      url,
      body: {
        'id': id.toString(),
      },
    );

    if (response.statusCode == 200) {
      mostrarAlerta("Suministro eliminado exitosamente");
      listarSuministro();
    } else {
      mostrarAlerta("Error al eliminar suministro");
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
    descripcionController.clear();
    tipo_desastreController.clear();
  }

  Future<void> agregarSuministroModal() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Suministro', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              FutureBuilder<List<TypeDisaster>>(
                future: listarDesastre(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error al cargar tipos de desastre');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No hay tipos de desastre disponibles');
                  } else {
                    List<TypeDisaster> tiposDesastre = snapshot.data!;
                    return DropdownButtonFormField<int>(
                    value: selectedTipoDesastre?.id,
                    onChanged: (value) {
                      setState(() {
                        selectedTipoDesastre = tiposDesastre.firstWhere((tipo) => tipo.id == value);
                      });
                    },
                    items: tiposDesastre.map((tipo) {
                      return DropdownMenuItem<int>(
                        value: tipo.id,
                        child: Text(tipo.nombre),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Tipo de desastre',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  );

                  }
                },
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
                agregarSuministro();
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
        title: Text('Lista de suministros'),
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
          itemCount: SupplyLists.length,
          itemBuilder: (context, index) {
            final SupplyList = SupplyLists[index];
            return Card(
              color: Colors.black,
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${SupplyList.nombre}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Descripción: ${SupplyList.descripcion}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Tipo de desastre: ${SupplyList.tipo_desastre}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    eliminarSuministro(SupplyList.id);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarSuministroModal,
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
