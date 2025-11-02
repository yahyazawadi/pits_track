import 'package:dio/dio.dart';
import 'package:food/category_model.dart';
import 'package:food/meal_model.dart';

class Fooddio {
  static final Fooddio _instance = Fooddio._internal();
  late final Dio _dio;
  Fooddio._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://www.themealdb.com/api/json/v1/1/",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }

  Future<List<Category>> fetchAllCategories() async {
    try {
      final responce = await _dio.get('categories.php');
      final categoryResponse = CategoryResponse.fromJson(responce.data);
      return categoryResponse.categories;
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<Meal>> fetchAllMealsByCategory(String category) async {
    try {
      final responce = await _dio.get("filter.php?c=$category");
      final mealResponce = MealResponseByCategory.fromJson(responce.data);
      return mealResponce.meals;
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<MealDetails> fetchMealDetailsById(String id) async {
    try {
      final responce = await _dio.get("lookup.php?i=$id");
      final mealDetailsResponce = MealDetails.fromJson(responce.data);
      return mealDetailsResponce;
    } catch (e) {
      throw Exception('Failed to load meal details: $e');
    }
  }
}
