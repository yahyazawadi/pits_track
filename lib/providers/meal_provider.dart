import 'package:flutter/material.dart';
import 'package:food/dio/food_dio.dart';
import 'package:food/models/meal_model.dart';

class MealProvider extends ChangeNotifier {
  final Fooddio _foodDio = Fooddio();
  final List<Meal> _meals = [];
  MealDetails? _mealDetails;
  String _currentCategory = '';
  bool _isLoading = false;
  String? _error;

  List<Meal> get meals => _meals;
  MealDetails? get mealDetails => _mealDetails;
  String get currentCategory => _currentCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getMealsByCategory(String category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final meals = await _foodDio.fetchAllMealsByCategory(category);
      _meals.clear();
      _meals.addAll(meals);
      _currentCategory = category;
    } catch (e) {
      _error = 'Failed to load meals: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMealDetailsById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _mealDetails = await _foodDio.fetchMealDetailsById(id);
    } catch (e) {
      _error = 'Failed to load meal details: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
