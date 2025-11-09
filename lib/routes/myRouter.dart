import 'package:flutter/material.dart';
import 'package:food/routes/routes.dart';
import 'package:food/screens/categories_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteNames.mealsByCategory:
        String? category = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => MealsByCategoryPage(category: category),
        );
      case RouteNames.category:
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
      case RouteNames.mealDetail:
        final mealId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MealDetailPage(mealId: mealId),
        );
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Home Page')));
  }
}

class MealsByCategoryPage extends StatelessWidget {
  String? category;
  MealsByCategoryPage({this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Meals by Category: ${category ?? "Unknown"}')),
    );
  }
}

class MealDetailPage extends StatelessWidget {
  final String mealId;
  MealDetailPage({required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Meal Detail for ID: $mealId')));
  }
}
