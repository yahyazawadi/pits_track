import 'package:flutter/material.dart';
import 'package:note_taking_app/data_manager/notes_manager.dart';
import 'package:note_taking_app/models/task.dart';
import 'package:note_taking_app/screens/tasks/task_card.dart';
import '../../routes/route_names.dart';

class TasksScreen extends StatefulWidget {
  static DataManager<Task> get tasksManager => _tasksManager;
  static final DataManager<Task> _tasksManager = DataManager(
    filename: "tasks.json",
    assetPath: "assets/tasks.json",
    fromJson: Task.fromJson,
  );

  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  // In NotesScreen and TasksScreen, modify initState:
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Add a small delay to ensure proper initialization
    await Future.delayed(const Duration(milliseconds: 100));

    if (!TasksScreen.tasksManager.initialized) {
      await TasksScreen.tasksManager.init();
    }

    // Force a refresh to ensure UI is in sync
    if (mounted) {
      setState(() {});
    }
  }

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, RouteNames.notes);
    } else {
      Navigator.pushNamed(context, RouteNames.tasks);
    }
  }

  // Add this method to refresh the screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Tasks', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(8.0),
        child: TasksScreen.tasksManager.isEmpty
            ? const Center(
                child: Text(
                  "add your first task to start",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: TasksScreen.tasksManager.length,
                itemBuilder: (context, index) {
                  final reversedIndex =
                      TasksScreen.tasksManager.length - 1 - index;
                  final task = TasksScreen.tasksManager[reversedIndex];
                  return TaskCard(
                    task: task,
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        RouteNames.taskEdit,
                        arguments: task.id,
                      );
                      setState(() {});
                    },
                    onToggle: () {
                      setState(() {
                        task.invert();
                        TasksScreen.tasksManager.save();
                      });
                    },
                  );
                },
              ),
      ),
      // Add this to your TasksScreen build method, inside the Scaffold:
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            RouteNames.taskEdit,
            arguments: null, // null indicates new task
          );
          setState(() {});
          ; // Refresh after returning
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.edit, color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
        ],
      ),
    );
  }
}
