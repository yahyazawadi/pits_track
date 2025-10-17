import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/screens/notes/notes_screen.dart';

class NoteEditScreen extends StatefulWidget {
  final String? noteId; // Make nullable for new notes

  const NoteEditScreen({this.noteId}); // Make optional

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _subTextController;
  late Note _currentNote;
  late bool _isNewNote;

  @override
  void initState() {
    super.initState();
    _isNewNote = widget.noteId == null;

    if (_isNewNote) {
      // Create new note
      _currentNote = Note(title: '', subText: '');
      _titleController = TextEditingController();
      _subTextController = TextEditingController();
    } else {
      // Edit existing note
      _currentNote = NotesScreen.notesManager.getById(widget.noteId!) as Note;
      _titleController = TextEditingController(text: _currentNote.title);
      _subTextController = TextEditingController(text: _currentNote.subText);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subTextController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_titleController.text.trim().isEmpty) {
      // Don't save empty notes, just go back
      Navigator.pop(context);
      return;
    }

    try {
      if (_isNewNote) {
        // For new notes, make sure we have the updated title/subtext
        _currentNote.update(
          title: _titleController.text,
          subText: _subTextController.text.isEmpty
              ? null
              : _subTextController.text,
        );
        await NotesScreen.notesManager.add(_currentNote);
        print('New note saved: ${_currentNote.title}');
      } else {
        // For existing notes, use updateById
        await NotesScreen.notesManager.updateById(
          id: _currentNote.id,
          title: _titleController.text,
          subText: _subTextController.text.isEmpty
              ? null
              : _subTextController.text,
        );
        print('Note updated: ${_currentNote.title}');
      }

      // Force save and wait for completion
      await NotesScreen.notesManager.save();

      Navigator.pop(context);
    } catch (e) {
      print('Error saving note: $e');
      // Optionally show an error message to user
    }
  }

  void _deleteNote() {
    if (_isNewNote) {
      // If it's a new note, just go back without saving
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              NotesScreen.notesManager.deleteById(_currentNote.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _isNewNote ? 'New Note' : 'Edit Note',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          if (!_isNewNote) // Only show delete for existing notes
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: _deleteNote,
            ),
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 24, 24, 24),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Note Title',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
              ),
              autofocus: _isNewNote, // Auto-focus for new notes
            ),

            const Divider(color: Colors.grey, height: 32),

            // Only show dates for existing notes
            if (!_isNewNote)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (_currentNote.editedAt != null)
                      Text(
                        "last edited: ${_currentNote.editedAt.toString().split(' ').first}",
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),

                    Text(
                      "written at: ${_currentNote.madeAt.toString().split(' ').first}",
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: TextField(
                controller: _subTextController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
