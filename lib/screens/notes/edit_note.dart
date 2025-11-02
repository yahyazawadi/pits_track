import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/providers/notes_provider.dart';

class NoteEditScreen extends StatefulWidget {
  final String? noteId;
  const NoteEditScreen({this.noteId});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _subTextController;
  late Note _currentNote;
  late bool _isNewNote;
  late NotesProvider _notesProvider;

  @override
  void initState() {
    super.initState();
    _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _isNewNote = widget.noteId == null;

    if (_isNewNote) {
      _currentNote = Note(title: '', subText: '');
      _titleController = TextEditingController();
      _subTextController = TextEditingController();
    } else {
      _currentNote = _notesProvider.getNoteById(widget.noteId!)!;
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
      Navigator.pop(context);
      return;
    }

    try {
      if (_isNewNote) {
        _currentNote.update(
          title: _titleController.text,
          subText: _subTextController.text.isEmpty
              ? null
              : _subTextController.text,
        );
        await _notesProvider.addNote(_currentNote);
      } else {
        await _notesProvider.updateNote(
          id: _currentNote.id,
          title: _titleController.text,
          subText: _subTextController.text.isEmpty
              ? null
              : _subTextController.text,
        );
      }

      // Provider will automatically notify listeners and refresh UI
      Navigator.pop(context);
    } catch (e) {
      print('Error saving note: $e');
    }
  }

  void _deleteNote() {
    if (_isNewNote) {
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
              _notesProvider.deleteNote(_currentNote.id);
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
          if (!_isNewNote)
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
              autofocus: _isNewNote,
            ),

            const Divider(color: Colors.grey, height: 32),

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
