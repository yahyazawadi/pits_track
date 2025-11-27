import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/tasks/data/model/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks; //read only access

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _error;
  String? get error => _error;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  int _currentSortOption = 2;

  List<TaskModel>? _cachedDisplayTasks;
  String _lastSearchQuery = '';
  int _lastSortOption = 0; //default is sort by date

  final SharedPreferences _prefs;

  TaskProvider(this._prefs) {
    //dependency injection
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final savedTasks = _prefs.getStringList('tasks') ?? [];
      _tasks = savedTasks
          .map((json) => TaskModel.fromJson(jsonDecode(json)))
          .toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to load tasks';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveTasks() async {
    final taskJsonList =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    await _prefs.setStringList('tasks', taskJsonList);
  }

  List<TaskModel> get displayTasks {
    if (!_shouldRebuildDisplayTasks() && _cachedDisplayTasks != null) {
      return _cachedDisplayTasks!;
    }

    _lastSearchQuery = _searchQuery;
    _lastSortOption = _currentSortOption;

    List<TaskModel> filtered;
    if (_searchQuery.isEmpty) {
      filtered = List.from(_tasks);
    } else {
      final q = _searchQuery.toLowerCase();
      filtered = _tasks.where((task) {
        return task.title.toLowerCase().contains(q) ||
            task.description.toLowerCase().contains(q);
      }).toList();
    }

    filtered.sort((a, b) {
      switch (_currentSortOption) {
        case 1:
          if (a.completed && !b.completed) return -1;
          if (!a.completed && b.completed) return 1;
          return 0;
        case 2: // Sort by pending first
          if (!a.completed && b.completed) return -1;
          if (a.completed && !b.completed) return 1;
          return 0;

        case 0: // Sort by date

        default:
          if (a.startDateTime == null && b.startDateTime == null) return 0;
          if (a.startDateTime == null) return 1;
          if (b.startDateTime == null) return -1;
          return a.startDateTime!.compareTo(b.startDateTime!);
      }
    });

    _cachedDisplayTasks = filtered;
    return filtered;
  }

  TaskModel? getTaskById(String taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  Future<void> addTask(TaskModel task) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (task.title.trim().isEmpty) throw 'Task title cannot be blank';
      if (task.description.trim().isEmpty)
        throw 'Task description cannot be blank';
      if (task.startDateTime == null) throw 'Missing task start date';
      if (task.stopDateTime == null) throw 'Missing task stop date';

      _tasks.add(task);
      await _saveTasks();
      _cachedDisplayTasks = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    _isLoading = true;

    try {
      if (updatedTask.title.trim().isEmpty) throw 'Task title cannot be blank';
      if (updatedTask.description.trim().isEmpty) {
        throw 'Task description cannot be blank';
      }
      if (updatedTask.startDateTime == null) throw 'Missing task start date';
      if (updatedTask.stopDateTime == null) throw 'Missing task stop date';

      final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
        await _saveTasks();
        _cachedDisplayTasks = null;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks.removeWhere((t) => t.id == taskId);
      await _saveTasks();
      _cachedDisplayTasks = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSortOption(int sortOption) {
    _currentSortOption = sortOption;
    _cachedDisplayTasks = null;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _cachedDisplayTasks = null;
    notifyListeners();
  }

  bool _shouldRebuildDisplayTasks() {
    if (_cachedDisplayTasks == null) return true;

    if (_lastSearchQuery != _searchQuery) return true;
    if (_lastSortOption != _currentSortOption) return true;

    if (_currentSortOption == 0) {
      for (int i = 0; i < _tasks.length; i++) {
        if (_cachedDisplayTasks == null) return true;
        if (i >= _cachedDisplayTasks!.length) return true;
        if (_tasks[i].startDateTime != _cachedDisplayTasks![i].startDateTime) {
          return true;
        }
      }
    }

    if (_currentSortOption == 1 || _currentSortOption == 2) {
      final completedCount = _tasks.where((t) => t.completed).length;
      final cachedCompletedCount =
          _cachedDisplayTasks?.where((t) => t.completed).length ?? 0;
      if (completedCount != cachedCompletedCount) return true;
    }

    return false;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
