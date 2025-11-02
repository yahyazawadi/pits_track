import 'package:flutter/material.dart';
import 'package:food/dio/foodDio.dart';
import 'package:food/routes/myRouter.dart';
import 'package:food/routes/routes.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          backgroundColor: Colors.red,
          child: Icon(Icons.shopping_cart),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomAppBar(
            elevation: 8.0,
            height: 60.0,
            color: Colors.red,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.category),
                  onPressed: () {
                    MyRouter.generateRoute(
                      RouteSettings(name: RouteNames.category),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.set_meal),
                  onPressed: () {
                    MyRouter.generateRoute(
                      RouteSettings(name: RouteNames.mealsByCategory),
                    );
                  },
                ),
                SizedBox(width: 30),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    MyRouter.generateRoute(
                      RouteSettings(name: RouteNames.home),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Action for settings
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.red),
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: RouteNames.category,
    );
  }
}
