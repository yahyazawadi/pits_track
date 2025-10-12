import 'dart:collection';
import 'package:note_taking_app/note.dart';

abstract class NotesRepository {
  UnmodifiableListView<Note> get notes;
  Future<void> init();
  Note? getNoteById(String id);
  Future<bool> add(Note note);
  Future<bool> updateById({
    required String id,
    required String title,
    required String text,
  });
  Future<bool> deleteById(String id);
}
