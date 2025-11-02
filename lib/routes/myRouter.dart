import 'package:flutter/material.dart';
import 'package:food/routes.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteNames.mealsByCategory:
        final category = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MealsByCategoryPage(category: category),
        );
      case RouteNames.category:
        return MaterialPageRoute(builder: (_) => CategoryPage());
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
