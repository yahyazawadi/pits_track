import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_taking_app/screens/notes/note_card.dart';
import 'package:note_taking_app/providers/notes_provider.dart';
import '../../routes/route_names.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.delayed(const Duration(milliseconds: 100));

    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    if (notesProvider.isLoading) {
      await notesProvider.init();
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
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    if (notesProvider.isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

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
        child: notesProvider.isEmpty
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
                itemCount: notesProvider.length,
                itemBuilder: (context, index) {
                  final reversedIndex = notesProvider.length - 1 - index;
                  final note = notesProvider[reversedIndex];
                  return NoteCard(note: note);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            RouteNames.noteEdit,
            arguments: null,
          );
          // No need to call setState - provider will notify listeners
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
