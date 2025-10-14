import 'package:collection/collection.dart';
import 'package:note_taking_app/models/basic_note.dart';
import 'package:note_taking_app/data%20manager/notes_repo.dart';
import 'package:note_taking_app/storage/storage.dart';

class DataManager<T extends BasicNote> implements NotesRepository<T> {
  final T Function(Map<String, dynamic>) _fromJson;
  final List<T> _items = [];
  bool _initialized = false;
  final Storage<T> _storage;

  DataManager({
    required String filename,
    required T Function(Map<String, dynamic>) fromJson,
  }) : _fromJson = fromJson,
       _storage = Storage<T>(filename);

  @override
  Future<void> init() async {
    if (_initialized) return;
    _items.addAll(await _storage.loadItems(_fromJson));
    _initialized = true;
  }

  @override
  T? getById(String id) {
    return _items.firstWhereOrNull((item) => item.id == id);
  }

  @override
  Future<void> save() => _storage.saveItems(_items);
  @override
  Future<bool> add(T item) async {
    _items.add(item);
    try {
      await save();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateById({
    required String id,
    required String title,
    required dynamic extraData,
  }) async {
    final existingItem = _items.firstWhereOrNull((n) => n.id == id);
    if (existingItem != null) {
      existingItem.update(title: title, extraData: extraData);
      await save();
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteById(String id) async {
    final index = _items.indexWhere((n) => n.id == id);
    if (index == -1) return false;

    _items.removeAt(index);
    await save();
    return true;
  }

  @override
  UnmodifiableListView<T> get basicNotes => UnmodifiableListView(_items);
}
