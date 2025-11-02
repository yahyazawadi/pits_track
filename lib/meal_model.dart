import 'package:json_annotation/json_annotation.dart';
part 'meal_model.g.dart';

@JsonSerializable()
class MealResponseByCategory {
  final List<Meal> meals;
  MealResponseByCategory({required this.meals});
  factory MealResponseByCategory.fromJson(Map<String, dynamic> json) =>
      _$MealResponseByCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$MealResponseByCategoryToJson(this);
}

@JsonSerializable()
class Meal {
  @JsonKey(name: "strMeal")
  final String mealName;
  @JsonKey(name: "idMeal")
  final String id;
  @JsonKey(name: "strMealThumb")
  final String thumbnail;

  Meal({required this.mealName, required this.id, required this.thumbnail});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}

@JsonSerializable()
class MealDetails {
  @JsonKey(name: "idMeal")
  final String id;
  @JsonKey(name: "strMeal")
  final String mealName;
  @JsonKey(name: "strCategory")
  final String category;
  @JsonKey(name: "strMealThumb")
  final String thumbnail;
  @JsonKey(name: "strInstructions")
  final String instructions;

  MealDetails({
    required this.id,
    required this.mealName,
    required this.category,
    required this.thumbnail,
    required this.instructions,
  });

  factory MealDetails.fromJson(Map<String, dynamic> json) =>
      _$MealDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailsToJson(this);
}
