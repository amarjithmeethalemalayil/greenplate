import 'package:green_plate/core/entity/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  const RecipeModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.readyInMinutes,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? 0,
    );
  }
  static RecipeModel fromEntity(RecipeEntity entity) {
    return RecipeModel(
      id: entity.id,
      title: entity.title,
      imageUrl: entity.imageUrl,
      readyInMinutes: entity.readyInMinutes,
    );
  }
}
