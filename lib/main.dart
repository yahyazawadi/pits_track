import 'package:flutter/material.dart';
import 'package:food/dio/foodDio.dart';
import 'package:food/myRouter.dart';
import 'package:food/routes.dart';

void main() {
  runApp(MyApp());
  // Run the test after the app starts
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Food App',
            style: TextStyle(color: Colors.white, fontFamily: 'Arial'),
          ),
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.red),
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: RouteNames.home,
    );
  }
}
