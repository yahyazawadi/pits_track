import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:note_taking_app/models/basic_note.dart';
import 'package:note_taking_app/data_manager/notes_repo.dart';
import 'package:note_taking_app/storage/storage.dart';

class DataManager<T extends BasicNote> implements NotesRepository<T> {
  final T Function(Map<String, dynamic>) _fromJson;
  List<T> _list = []; // Remove final to allow reassignment
  bool _initialized = false;
  bool get initialized => _initialized;
  final Storage<T> _storage;
  final String _assetPath;

  DataManager({
    required String filename,
    required String assetPath,
    required T Function(Map<String, dynamic>) fromJson,
  }) : _fromJson = fromJson,
       _assetPath = assetPath,
       _storage = Storage<T>(filename);

  @override
  Future<void> init() async {
    if (_initialized) {
      print('Already initialized, skipping...');
      return;
    }

    print('Initializing DataManager...');
    await _copyFromAssetsIfNeeded();

    // CLEAR the list first to avoid duplicates
    _list.clear();

    final loadedItems = await _storage.loadItems(_fromJson);
    print('Loaded ${loadedItems.length} items from storage');

    _list.addAll(loadedItems);
    _initialized = true;
    print('Initialization complete. Total items: ${_list.length}');
  }

  Future<void> _copyFromAssetsIfNeeded() async {
    final file = await _storage.file;
    bool localFileExists = await file.exists();

    if (!localFileExists) {
      print('Local file not found, copying from assets: $_assetPath');
      await _copyFromAssets();
    } else {
      print('Local file exists, skipping asset copy.');
    }
  }

  Future<void> _copyFromAssets() async {
    try {
      String data = await rootBundle.loadString(_assetPath);
      await _storage.saveRawData(data);
      print('Successfully copied asset to local storage.');
    } catch (e) {
      print('Error copying asset from $_assetPath: $e');
      // Create an empty file as a fallback
      await _storage.saveItems([]);
    }
  }

  @override
  T? getById(String id) {
    return _list.firstWhereOrNull((n) => n.id == id);
  }

  @override
  Future<void> save() async {
    print('Saving ${_list.length} items...');
    await _storage.saveItems(_list);
    print('Save complete.');
  }

  @override
  Future<void> add(T item) async {
    // Check if item with same ID already exists
    if (_list.any((existing) => existing.id == item.id)) {
      print('Item with ID ${item.id} already exists. Updating instead.');
      await updateById(id: item.id, title: item.title, subText: item.subText);
      return;
    }

    _list.add(item);
    print('Added item: ${item.title} (ID: ${item.id})');
    await save();
  }

  @override
  Future<void> updateById({
    required String id,
    required String title,
    required String? subText,
  }) async {
    final existingItem = _list.firstWhereOrNull((n) => n.id == id);
    if (existingItem != null) {
      print('Updating item: $id - "$title"');
      existingItem.update(title: title, subText: subText);
      await save();
    } else {
      print('Item with ID $id not found for update.');
    }
  }

  @override
  Future<void> deleteById(String id) async {
    final initialLength = _list.length;
    _list.removeWhere((n) => n.id == id);

    if (_list.length < initialLength) {
      print('Deleted item with ID: $id');
      await save();
    } else {
      print('Item with ID $id not found for deletion.');
    }
  }

  @override
  UnmodifiableListView<T> get basicNotes => UnmodifiableListView(_list);

  @override
  int get length => _list.length;

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  T operator [](int index) => _list[index];

  // Add a method to force reload from storage
  Future<void> reload() async {
    print('Forcing reload from storage...');
    _initialized = false;
    await init();
  }

  void printAll() {
    print('=== Current Items (${_list.length}) ===');
    for (var note in _list) {
      print(
        'ID: ${note.id}, Title: "${note.title}", Date: ${note.displayDate}',
      );
    }
    if (_list.isEmpty) {
      print('No items available.');
    }
    print('=== End ===');
  }
}
