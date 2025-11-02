import 'package:flutter/material.dart';
import 'package:food/dio/foodDio.dart';
import 'package:food/models/meal_model.dart';

class MealProvider extends ChangeNotifier {
  final Fooddio _foodDio = Fooddio();
  final List<Meal> _meals = [];
  MealDetails? _mealDetails;
  List<Meal> get meals => _meals;
  String _currentCategory = '';
  MealDetails? get mealDetails => _mealDetails;
  String get currentCategory => _currentCategory;
  Future<void> getMealsByCategory(String category) async {
    try {
      _meals.addAll(await _foodDio.fetchAllMealsByCategory(category));
      _currentCategory = category;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<void> getMealDetailsById(String id) async {
    try {
      _mealDetails = await _foodDio.fetchMealDetailsById(id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load meal details: $e');
    }
  }
}
