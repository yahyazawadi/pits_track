import 'package:flutter/material.dart';
import 'package:note_taking_app/data_manager/notes_manager.dart';
import 'package:note_taking_app/models/note.dart';

class NotesProvider extends ChangeNotifier {
  final DataManager<Note> _notesManager = DataManager<Note>(
    filename: "notes.json",
    assetPath: "assets/notes.json",
    fromJson: Note.fromJson,
  );

  DataManager<Note> get notesManager => _notesManager;
  bool _isInitialized = false;

  Future<void> init() async {
    if (!_isInitialized) {
      await _notesManager.init();
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    notifyListeners();
  }
}
