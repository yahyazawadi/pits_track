import 'package:note_taking_app/notes_repo.dart';
import 'package:note_taking_app/notes_storage.dart';
import 'package:note_taking_app/note.dart';
import 'package:collection/collection.dart';

class NotesManager implements NotesRepository {
  NotesManager._(); // Private constructor for singleton pattern
  static final NotesManager instance = NotesManager._(); // Singleton instance
  final List<Note> _notes = [];
  bool _initialized = false;
  @override
  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  @override
  Future<void> init() async {
    if (_initialized) return;

    _notes.addAll(await Storage.loadNotes());
    _initialized = true;
  }

  @override
  Note? getNoteById(String id) {
    return _notes.firstWhereOrNull((note) => note.id == id);
  }

  /// Adds a new note to the collection and saves to storage
  @override
  Future<bool> add(Note note) async {
    _notes.add(note);
    try {
      await _save();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Updates an existing note and saves to storage
  /// Does nothing if the note doesn't exist
  @override
  Future<bool> updateById({
    required String id,
    required String title,
    required String text,
  }) async {
    final existingNote = _notes.firstWhereOrNull((n) => n.id == id);
    if (existingNote != null) {
      existingNote.update(title: title, text: text);
      await _save();
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteById(String id) async {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index == -1) return false;

    _notes.removeAt(index);
    await _save();
    return true;
  }

  /// Saves all notes to json storage
  Future<void> _save() => Storage.saveNotes(_notes);
}

// Future<bool> deleteById(String id) async {

  //   final removed = (_notes.removeWhere((n) => n.id == id) > 0);
  //   if (removed) await _save();
  //   return removed;
  // }