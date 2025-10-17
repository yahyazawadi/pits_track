import 'dart:convert';
import 'dart:io';

import 'package:note_taking_app/models/basic_note.dart';
import 'package:path_provider/path_provider.dart';

class Storage<T extends BasicNote> {
  final String filename;

  Storage(this.filename);

  Future<File> get _file async =>
      File('${(await getApplicationDocumentsDirectory()).path}/$filename');

  // Make _file getter accessible to DataManager for existence check
  Future<File> get file async => _file;

  Future<List<T>> loadItems(T Function(Map<String, dynamic>) fromJson) async {
    try {
      final file = await _file;
      if (!await file.exists()) {
        print('File does not exist: ${file.path}');
        return [];
      }

      final jsonString = await file.readAsString();
      if (jsonString.isEmpty) {
        print('File is empty: ${file.path}');
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      print('Loaded ${jsonList.length} items from: ${file.path}');
      return jsonList
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading items: $e');
      return [];
    }
  }

  Future<void> saveItems(List<T> items) async {
    final file = await _file;
    final jsonList = items.map((item) => item.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
    print('Saved ${items.length} items to: ${file.path}');
  }

  Future<void> saveRawData(String data) async {
    final file = await _file;
    await file.writeAsString(data);
    print('Saved raw data to: ${file.path}');
  }
}
