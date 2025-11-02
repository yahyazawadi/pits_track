import 'package:flutter/material.dart';
import 'package:note_taking_app/data_manager/notes_manager.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/models/task.dart';
import 'package:provider/provider.dart';
import 'package:note_taking_app/providers/notes_provider.dart';
import 'package:note_taking_app/providers/task_provider.dart';
import 'package:note_taking_app/routes/app_router.dart';
import 'package:note_taking_app/routes/route_names.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => TasksProvider()),
        Provider<DataManager<Note>>(
          create: (_) => DataManager<Note>(
            filename: "notes.json",
            assetPath: "assets/notes.json",
            fromJson: Note.fromJson,
          ),
        ),
        Provider<DataManager<Task>>(
          create: (_) => DataManager<Task>(
            filename: "tasks.json",
            assetPath: "assets/tasks.json",
            fromJson: Task.fromJson,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.dark(),
      initialRoute: RouteNames.notes,
      onGenerateRoute: MyRouter.generate,
    );
  }
}
