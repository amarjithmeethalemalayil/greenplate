import 'package:green_plate/features/ai_recipe/domain/entity/ai_recipe_entity.dart';

class AiRecipeModel extends AiRecipeEntity {
  AiRecipeModel({required super.id});

  factory AiRecipeModel.fromJson(Map<String, dynamic> json) {
    return AiRecipeModel(
      id: json['id'] as int,
    );
  }
}
