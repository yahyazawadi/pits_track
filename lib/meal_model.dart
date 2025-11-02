import 'package:json_annotation/json_annotation.dart';
part 'meal_model.g.dart';

@JsonSerializable()
class MealResponse // all meals
{
  final List<Meal> meals;
  MealResponse({required this.meals});
  factory MealResponse.fromJson(Map<String, dynamic> json) =>
      _$MealResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealResponseToJson(this);
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
class MealDetailResponse // meal detail
{
  final List<MealDetail> mealDetails;
  MealDetailResponse({required this.mealDetails});
  factory MealDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MealDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailResponseToJson(this);
}

@JsonSerializable()
class MealDetail {
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

  MealDetail({
    required this.id,
    required this.mealName,
    required this.category,
    required this.thumbnail,
    required this.instructions,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) =>
      _$MealDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailToJson(this);
}
