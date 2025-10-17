import 'package:flutter/material.dart';
import 'package:note_taking_app/models/task.dart';
import 'package:note_taking_app/screens/tasks/tasks_screen.dart';

class EditTask extends StatefulWidget {
  final String? taskId; // Make nullable for new tasks

  const EditTask({this.taskId}); // Make optional

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _titleController;
  late Task _currentTask;
  late bool _isNewTask;

  @override
  void initState() {
    super.initState();
    _isNewTask = widget.taskId == null;

    if (_isNewTask) {
      // Create new task
      _currentTask = Task(title: '', isDone: false);
      _titleController = TextEditingController();
    } else {
      // Edit existing task
      _currentTask = TasksScreen.tasksManager.getById(widget.taskId!) as Task;
      _titleController = TextEditingController(text: _currentTask.title);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _toggleTask() {
    setState(() {
      _currentTask.invert();
    });
    TasksScreen.tasksManager.save();
  }

  void _saveTask() async {
    if (_titleController.text.trim().isEmpty) {
      // Don't save empty notes, just go back
      Navigator.pop(context);
      return;
    }

    try {
      if (_isNewTask) {
        // For new tasks, make sure we have the updated title
        _currentTask.update(title: _titleController.text);
        await TasksScreen.tasksManager.add(_currentTask);
        print('New task saved: ${_currentTask.title}');
      } else {
        // For existing tasks, use updateById
        await TasksScreen.tasksManager.updateById(
          id: _currentTask.id,
          title: _titleController.text,
          subText: null, // Tasks don't have subtext
        );
        print('Task updated: ${_currentTask.title}');
      }

      // Force save and wait for completion
      await TasksScreen.tasksManager.save();

      Navigator.pop(context);
    } catch (e) {
      print('Error saving task: $e');
      // Optionally show an error message to user
    }
  }

  void _deleteTask() {
    if (_isNewTask) {
      // If it's a new task, just go back without saving
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              TasksScreen.tasksManager.deleteById(_currentTask.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to tasks
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _isNewTask ? 'New Task' : 'Edit Task',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          if (!_isNewTask) // Only show delete for existing tasks
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: _deleteTask,
            ),
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 24, 24, 24),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Checkbox and Title Row
            Row(
              children: [
                // Only show checkbox for existing tasks
                if (!_isNewTask)
                  Checkbox(
                    value: _currentTask.isDone,
                    onChanged: (bool? value) => _toggleTask(),
                    fillColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.green;
                      }
                      return Colors.grey;
                    }),
                  ),
                if (!_isNewTask) const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: (!_isNewTask && _currentTask.isDone)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Task Title',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                    autofocus: _isNewTask, // Auto-focus for new tasks
                  ),
                ),
              ],
            ),

            const Divider(color: Colors.grey, height: 32),

            // Only show dates for existing tasks
            if (!_isNewTask)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_currentTask.editedAt != null)
                      Text(
                        "last edited: ${_currentTask.editedAt.toString().split(' ').first}",
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    Text(
                      "written at: ${_currentTask.madeAt.toString().split(' ').first}",
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),

            // Empty expanded space
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
