import 'dart:collection';
import 'package:note_taking_app/models/basic_note.dart';

abstract class NotesRepository<T extends BasicNote> {
  Future<void> init();
  T? getById(String id);
  Future<bool> add(T basicNote);
  Future<bool> updateById({
    required String id,
    required String title,
    required dynamic extraData,
  });

  Future<bool> deleteById(String id);
  Future<void> save();
  UnmodifiableListView<T> get basicNotes;
}
