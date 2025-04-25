import 'package:green_plate/features/recipe_detail_view/domain/entity/ingredient_entity.dart';

class RecipeDetailEntity {
  final int id;
  final String image;
  final String title;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final bool veryHealthy;
  final bool cheap;
  final bool veryPopular;
  final bool sustainable;
  final bool lowFodmap;
  final double weightWatcherSmartPoints;
  final String gaps;
  final double healthScore;
  final String creditsText;
  final String license;
  final String sourceName;
  final double pricePerServing;
  final List<String> dishTypes;
  final List<String> diets;
  final List<String> occasions;
  final List<IngredientEntity> extendedIngredients;
  final String instructions;

  RecipeDetailEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.cheap,
    required this.veryPopular,
    required this.sustainable,
    required this.lowFodmap,
    required this.weightWatcherSmartPoints,
    required this.gaps,
    required this.healthScore,
    required this.creditsText,
    required this.license,
    required this.sourceName,
    required this.pricePerServing,
    required this.dishTypes,
    required this.diets,
    required this.occasions,
    required this.extendedIngredients,
    required this.instructions,
  });
}


