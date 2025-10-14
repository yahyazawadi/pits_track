import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text('Notes', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Text('Hello, world!', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
