import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas', style: TextStyle(fontSize: 24)),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[800],
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                notes[index].title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                notes[index].content,
                style: TextStyle(color: Colors.grey[400]),
              ),
              onLongPress: () {
                _deleteNote(notes[index].id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNoteScreen()),
          ).then((newNote) {
            if (newNote != null) {
              setState(() {
                notes.add(newNote);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteNote(String noteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text(
            'Eliminar Nota',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            '¿Estás seguro de que deseas eliminar esta nota?',
            style: TextStyle(color: Colors.grey[400]),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notes.removeWhere((note) => note.id == noteId);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Note {
  final String id;
  final String title;
  final String content;

  Note(this.id, this.title, this.content);
}

class CreateNoteScreen extends StatefulWidget {
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Nota', style: TextStyle(fontSize: 24)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Contenido',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = _titleController.text;
                final newContent = _contentController.text;
                if (newTitle.isNotEmpty && newContent.isNotEmpty) {
                  final newNote = Note(_uuid.v4(), newTitle, newContent);
                  Navigator.pop(context, newNote);
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
