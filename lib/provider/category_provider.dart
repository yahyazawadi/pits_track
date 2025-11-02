import 'package:flutter/material.dart';
import 'package:food/dio/foodDio.dart';
import 'package:food/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final Fooddio _foodDio = Fooddio();
  final List<Category> _categories = [];
  Future<void> getAllCategories() async {
    try {
      _categories.addAll(await _foodDio.fetchAllCategories());
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  List<Category> get categories => _categories;
}
