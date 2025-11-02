import 'package:flutter/material.dart';
import 'package:food/foodDio.dart';

void main() {
  runApp(MyApp());
  // Run the test after the app starts
  WidgetsFlutterBinding.ensureInitialized();
  _testApi();
}

void _testApi() async {
  print('🚀 STARTING API TESTS...\n');

  final foodApi = Fooddio();

  // Test 1: Fetch Categories
  print('📋 TEST 1: Fetching Categories...');
  try {
    final categories = await foodApi.fetchAllCategories();
    print('✅ SUCCESS: Got ${categories.length} categories');
    if (categories.isNotEmpty) {
      print('   First category: ${categories.first.name}');
      print('   Thumbnail: ${categories.first.thumbnail}');
    }
  } catch (e) {
    print('❌ ERROR: $e');
  }

  print('\n---\n');

  // Test 2: Fetch Meals by Category
  print('🍽️ TEST 2: Fetching Meals by Category...');
  try {
    final meals = await foodApi.fetchAllMealsByCategory('Seafood');
    print('✅ SUCCESS: Got ${meals.length} seafood meals');
    if (meals.isNotEmpty) {
      print('   First meal: ${meals.first.mealName}');
      print('   Meal ID: ${meals.first.id}');
      print('   Thumbnail: ${meals.first.thumbnail}');
    }
  } catch (e) {
    print('❌ ERROR: $e');
  }

  print('\n---\n');

  // Test 3: Fetch Meal Details
  print('🔍 TEST 3: Fetching Meal Details...');
  try {
    // Using a known meal ID from the seafood category
    final mealDetail = await foodApi.fetchMealDetailsById('52772');
    print('✅ SUCCESS: Got meal details');
    print('   Meal: ${mealDetail.mealName}');
    print('   Category: ${mealDetail.category}');
    print(
      '   Instructions length: ${mealDetail.instructions.length} characters',
    );
  } catch (e) {
    print('❌ ERROR: $e');
  }

  print('\n🎯 ALL TESTS COMPLETED!');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food API Test',
      home: Scaffold(
        appBar: AppBar(title: Text('API Test Running... Check Console!')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant, size: 50, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Check your console for API test results!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
