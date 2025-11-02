// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealResponse _$MealResponseFromJson(Map<String, dynamic> json) => MealResponse(
  meals: (json['meals'] as List<dynamic>)
      .map((e) => Meal.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MealResponseToJson(MealResponse instance) =>
    <String, dynamic>{'meals': instance.meals};

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

MealDetailResponse _$MealDetailResponseFromJson(Map<String, dynamic> json) =>
    MealDetailResponse(
      mealDetails: (json['mealDetails'] as List<dynamic>)
          .map((e) => MealDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealDetailResponseToJson(MealDetailResponse instance) =>
    <String, dynamic>{'mealDetails': instance.mealDetails};

MealDetail _$MealDetailFromJson(Map<String, dynamic> json) => MealDetail(
  id: json['idMeal'] as String,
  mealName: json['strMeal'] as String,
  category: json['strCategory'] as String,
  thumbnail: json['strMealThumb'] as String,
  instructions: json['strInstructions'] as String,
);

Map<String, dynamic> _$MealDetailToJson(MealDetail instance) =>
    <String, dynamic>{
      'idMeal': instance.id,
      'strMeal': instance.mealName,
      'strCategory': instance.category,
      'strMealThumb': instance.thumbnail,
      'strInstructions': instance.instructions,
    };
