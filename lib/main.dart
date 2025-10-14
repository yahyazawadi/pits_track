import 'package:flutter/material.dart';
import 'package:note_taking_app/data%20manager/notes_manager.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static DataManager<Note> notesManager = DataManager(
    filename: "notes.json",
    fromJson: Note.fromJson,
  );
  static DataManager<Task> tasksManager = DataManager(
    filename: "tasks.json",
    fromJson: Task.fromJson,
  );
  @override
  void initState() {
    super.initState();

    notesManager.init();
    tasksManager.init();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text('Notes', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Container(
          color: Colors.grey[900],
          child: Center(
            child: Text('Hello, world!', style: TextStyle(color: Colors.white)),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,

          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Notes'),

            BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          ],
        ),
      ),
    );
  }
}
