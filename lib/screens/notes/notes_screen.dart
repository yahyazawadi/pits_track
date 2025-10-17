import 'package:flutter/material.dart';
import 'package:note_taking_app/data_manager/notes_manager.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/screens/notes/note_card.dart';
import '../../routes/route_names.dart';

class NotesScreen extends StatefulWidget {
  static DataManager<Note> get notesManager => _notesManager;
  static final DataManager<Note> _notesManager = DataManager(
    filename: "notes.json",
    assetPath: "assets/notes.json",
    fromJson: Note.fromJson,
  );

  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Add a small delay to ensure proper initialization
    await Future.delayed(const Duration(milliseconds: 100));

    if (!NotesScreen.notesManager.initialized) {
      await NotesScreen.notesManager.init();
    }

    // Force a refresh to ensure UI is in sync
    if (mounted) {
      setState(() {});
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, RouteNames.notes);
    } else {
      Navigator.pushNamed(context, RouteNames.tasks);
    }

    NotesScreen.notesManager.printAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Notes', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(8.0),
        child: NotesScreen.notesManager.isEmpty
            ? const Center(
                child: Text(
                  "write your first note to start",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: NotesScreen.notesManager.length,
                itemBuilder: (context, index) {
                  final reversedIndex =
                      NotesScreen.notesManager.length - 1 - index;
                  final note = NotesScreen.notesManager[reversedIndex];
                  return NoteCard(note: note);
                },
              ),
      ),
      // Add this to your NotesScreen build method, inside the Scaffold:
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            RouteNames.noteEdit,
            arguments: null, // null indicates new note
          );
          setState(() {}); // Refresh after returning
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.edit, color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
        ],
      ),
    );
  }
}
