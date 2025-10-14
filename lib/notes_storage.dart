import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'models/note.dart';

class Storage {
  static Future<File> get _file async =>
      File('${(await getApplicationDocumentsDirectory()).path}/notes.json');

  static Future<List<Note>> loadNotes() async {
    try {
      final file = await _file;
      return (jsonDecode(await file.readAsString()) as List)
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> saveNotes(List<Note> notes) async => (await _file)
      .writeAsString(jsonEncode(notes.map((n) => n.toJson()).toList()));
}
