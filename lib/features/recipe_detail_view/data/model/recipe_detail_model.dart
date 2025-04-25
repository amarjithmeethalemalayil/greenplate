import 'package:green_plate/features/recipe_detail_view/data/model/ingredient_model.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';

class RecipeDetailModel extends RecipeDetailEntity {
  RecipeDetailModel({
    required super.id,
    required super.image,
    required super.title,
    required super.readyInMinutes,
    required super.servings,
    required super.sourceUrl,
    required super.vegetarian,
    required super.vegan,
    required super.glutenFree,
    required super.dairyFree,
    required super.veryHealthy,
    required super.cheap,
    required super.veryPopular,
    required super.sustainable,
    required super.lowFodmap,
    required super.weightWatcherSmartPoints,
    required super.gaps,
    required super.healthScore,
    required super.creditsText,
    required super.license,
    required super.sourceName,
    required super.pricePerServing,
    required super.dishTypes,
    required super.diets,
    required super.occasions,
    required super.extendedIngredients,
    required super.instructions,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    var ingredientsList = json['extendedIngredients'] as List? ?? [];
    List<IngredientModel> ingredients = ingredientsList
        .map((ingredientJson) => IngredientModel.fromJson(ingredientJson))
        .toList();
    return RecipeDetailModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      glutenFree: json['glutenFree'],
      dairyFree: json['dairyFree'],
      veryHealthy: json['veryHealthy'],
      cheap: json['cheap'],
      veryPopular: json['veryPopular'],
      sustainable: json['sustainable'],
      lowFodmap: json['lowFodmap'],
      weightWatcherSmartPoints:
          (json['weightWatcherSmartPoints'] as num?)?.toDouble() ?? 0.0,
      gaps: json['gaps'],
      healthScore: (json['healthScore'] as num?)?.toDouble() ?? 0.0,
      creditsText: json['creditsText'],
      license: json['license'],
      sourceName: json['sourceName'],
      pricePerServing: (json['pricePerServing'] as num?)?.toDouble() ?? 0.0,
      dishTypes: List<String>.from(json['dishTypes'] ?? []),
      diets: List<String>.from(json['diets'] ?? []),
      occasions: List<String>.from(json['occasions'] ?? []),
      extendedIngredients: ingredients,
      instructions: json['instructions'],
    );
  }
}
