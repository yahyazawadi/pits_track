// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealResponseByCategory _$MealResponseByCategoryFromJson(
  Map<String, dynamic> json,
) => MealResponseByCategory(
  meals: (json['meals'] as List<dynamic>)
      .map((e) => Meal.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MealResponseByCategoryToJson(
  MealResponseByCategory instance,
) => <String, dynamic>{'meals': instance.meals};

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
  mealName: json['strMeal'] as String,
  id: json['idMeal'] as String,
  thumbnail: json['strMealThumb'] as String,
);

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
  'strMeal': instance.mealName,
  'idMeal': instance.id,
  'strMealThumb': instance.thumbnail,
};

MealDetailsList _$MealDetailsListFromJson(Map<String, dynamic> json) =>
    MealDetailsList(
      meals: (json['meals'] as List<dynamic>)
          .map((e) => MealDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealDetailsListToJson(MealDetailsList instance) =>
    <String, dynamic>{'meals': instance.meals};

MealDetails _$MealDetailsFromJson(Map<String, dynamic> json) => MealDetails(
  id: json['idMeal'] as String,
  mealName: json['strMeal'] as String,
  category: json['strCategory'] as String,
  thumbnail: json['strMealThumb'] as String,
  instructions: json['strInstructions'] as String,
);

Map<String, dynamic> _$MealDetailsToJson(MealDetails instance) =>
    <String, dynamic>{
      'idMeal': instance.id,
      'strMeal': instance.mealName,
      'strCategory': instance.category,
      'strMealThumb': instance.thumbnail,
      'strInstructions': instance.instructions,
    };
