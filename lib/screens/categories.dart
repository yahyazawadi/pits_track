import 'package:flutter/material.dart';
import 'package:food/models/category_model.dart';
import 'package:food/provider/category_provider.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryProvider categoryProvider = CategoryProvider();

  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.92,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(category: categories[index]);
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),

      child: Stack(
        children: [
          ClipRRect(
            child: Image.network(
              category.Thumbnail,
              width: double.infinity,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 80,
            left: 8,
            child: Text(
              category.Name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Text(
              category.Description,
              style: TextStyle(fontSize: 10),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
