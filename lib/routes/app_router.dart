import 'package:flutter/material.dart';
import '../screens/notes/notes_screen.dart';
import '../screens/tasks/tasks_screen.dart';
import '../screens/notes/edit_note.dart';
import '../screens/tasks/edit_task.dart';
import 'route_names.dart';

class MyRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.notes:
        return MaterialPageRoute(builder: (_) => NotesScreen());

      case RouteNames.tasks:
        return MaterialPageRoute(builder: (_) => TasksScreen());

      case RouteNames.noteEdit:
        final noteId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => NoteEditScreen(noteId: noteId),
        );
      case RouteNames.taskEdit:
        final taskId = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => EditTask(taskId: taskId));

      default:
        return MaterialPageRoute(builder: (_) => NotesScreen());
    }
  }
}
