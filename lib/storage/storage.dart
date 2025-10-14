// Generic storage manager that handles any BasicNote type
import 'dart:convert';
import 'dart:io';

import 'package:note_taking_app/models/basic_note.dart';
import 'package:path_provider/path_provider.dart';

class Storage<T extends BasicNote> {
  final String filename;

  Storage(this.filename);

  Future<File> get _file async =>
      File('${(await getApplicationDocumentsDirectory()).path}/$filename');

  Future<List<T>> loadItems(T Function(Map<String, dynamic>) fromJson) async {
    try {
      final file = await _file;
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveItems(List<T> items) async {
    final file = await _file;
    final jsonList = items.map((item) => item.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }
}
