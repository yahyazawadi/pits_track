import 'package:flutter/material.dart';
import 'package:food/dio/food_dio.dart';
import 'package:food/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final Fooddio _foodDio = Fooddio();
  final List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getAllCategories() async {
    if (_categories.isNotEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final categories = await _foodDio.fetchAllCategories();
      _categories.clear();
      _categories.addAll(categories);
    } catch (e) {
      _error = 'Failed to load categories: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
