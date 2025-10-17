import 'package:flutter/material.dart';
import 'package:note_taking_app/data_manager/notes_manager.dart';
import 'package:note_taking_app/models/task.dart';

class TasksProvider extends ChangeNotifier {
  final DataManager<Task> _tasksManager = DataManager<Task>(
    filename: "tasks.json",
    assetPath: "assets/tasks.json",
    fromJson: Task.fromJson,
  );

  DataManager<Task> get tasksManager => _tasksManager;
  bool _isInitialized = false;

  Future<void> init() async {
    if (!_isInitialized) {
      await _tasksManager.init();
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    notifyListeners();
  }
}
