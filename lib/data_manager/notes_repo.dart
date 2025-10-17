import 'dart:collection';
import 'package:note_taking_app/models/basic_note.dart';

abstract class NotesRepository<T extends BasicNote> {
  Future<void> init();

  T? getById(String id);

  Future<void> add(T basicNote);

  Future<void> updateById({
    required String id,
    required String title,
    required String? subText,
  });

  Future<void> deleteById(String id);

  Future<void> save();

  UnmodifiableListView<T> get basicNotes;
  int get length;
  bool get isEmpty;

  T operator [](int index);
}
