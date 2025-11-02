// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{'categories': instance.categories};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['idCategory'] as String,
  name: json['strCategory'] as String,
  thumbnail: json['strCategoryThumb'] as String,
  description: json['strCategoryDescription'] as String,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'idCategory': instance.id,
  'strCategory': instance.name,
  'strCategoryThumb': instance.thumbnail,
  'strCategoryDescription': instance.description,
};
