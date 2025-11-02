import 'package:flutter/material.dart';
import 'package:food/dio/foodDio.dart';
import 'package:food/routes/myRouter.dart';
import 'package:food/routes/routes.dart';

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
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Navigate to home
                },
              ),
              IconButton(
                icon: Icon(Icons.category),
                onPressed: () {
                  // Navigate to categories
                },
              ),
            ],
          ),
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.red),
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: RouteNames.home,
    );
  }
}
