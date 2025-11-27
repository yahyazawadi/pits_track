import 'package:flutter/material.dart';
import 'package:task_manager_app/routes/pages.dart';
import 'package:task_manager_app/tasks/data/model/task_model.dart';
import 'package:task_manager_app/tasks/presentation/pages/new_task_screen.dart';
import 'package:task_manager_app/tasks/presentation/pages/tasks_screen.dart';
import 'package:task_manager_app/tasks/presentation/pages/update_task_screen.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Pages.home:
      print("from router navigating to home");
      return MaterialPageRoute(builder: (context) => const TasksScreen());
    case Pages.createNewTask:
      print("from router navigating to create new task");
      return MaterialPageRoute(builder: (context) => const NewTaskScreen());
    case Pages.updateTask:
      print("from router navigating to update task");
      final args = routeSettings.arguments as TaskModel;
      return MaterialPageRoute(
        builder: (context) => UpdateTaskScreen(taskModel: args),
      );
    default:
      print("from router navigating to default (home)");
      return MaterialPageRoute(builder: (context) => const TasksScreen());
  }
}
