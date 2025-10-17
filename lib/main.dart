import 'package:flutter/material.dart';
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
