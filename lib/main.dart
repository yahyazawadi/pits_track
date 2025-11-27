import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/routes/app_router.dart';
import 'package:task_manager_app/routes/pages.dart';
import 'package:task_manager_app/tasks/data/provider/tasks_provider.dart';
import 'package:task_manager_app/utils/color_palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: preferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(prefs),
      child: MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        initialRoute: Pages.home,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          fontFamily: 'Sora',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
          useMaterial3: true,
        ),
      ),
    );
  }
}
