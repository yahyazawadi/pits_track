import 'package:flutter/foundation.dart';
import 'package:note_taking_app/data_manager/notes_manager.dart';
import 'package:note_taking_app/models/note.dart';

class NotesProvider with ChangeNotifier {
  final DataManager<Note> _notesManager = DataManager<Note>(
    filename: "notes.json",
    assetPath: "assets/notes.json",
    fromJson: Note.fromJson,
  );

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Note> get notes => _notesManager.basicNotes;
  int get length => _notesManager.length;
  bool get isEmpty => _notesManager.isEmpty;
  Note operator [](int index) => _notesManager[index];

  Future<void> init() async {
    if (!_notesManager.initialized) {
      await _notesManager.init();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _notesManager.add(note);
    notifyListeners();
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String? subText,
  }) async {
    await _notesManager.updateById(id: id, title: title, subText: subText);
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    await _notesManager.deleteById(id);
    notifyListeners();
  }

  Note? getNoteById(String id) {
    return _notesManager.getById(id);
  }

  Future<void> save() async {
    await _notesManager.save();
  }

  void refresh() {
    notifyListeners();
  }
}
