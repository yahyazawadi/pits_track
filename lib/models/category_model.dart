import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryResponse // all categories
{
  final List<Category> categories;
  CategoryResponse({required this.categories});
  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "idCategory")
  final String id;
  @JsonKey(name: "strCategory")
  final String name;
  @JsonKey(name: "strCategoryThumb")
  final String thumbnail;
  @JsonKey(name: "strCategoryDescription")
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  String get Id => id;
  String get Name => name;
  String get Thumbnail => thumbnail;
  String get Description => description;
}
