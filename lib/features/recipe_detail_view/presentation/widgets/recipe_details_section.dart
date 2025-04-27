import 'package:flutter/material.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_detail_row_items.dart';

class RecipeDetailsSection extends StatelessWidget {
  final RecipeDetailEntity recipeDetailEntity;
  const RecipeDetailsSection({
    super.key,
    required this.recipeDetailEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeDetailRowItems(
          purpose: "Ready in: ",
          value: "${recipeDetailEntity.readyInMinutes} minutes",
        ),
        RecipeDetailRowItems(
          purpose: "Servings: ",
          value: "${recipeDetailEntity.servings}",
        ),
        RecipeDetailRowItems(
          purpose: "Vegetarian: ",
          value: recipeDetailEntity.vegetarian ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Vegan: ",
          value: recipeDetailEntity.vegan ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Gluten-Free: ",
          value: recipeDetailEntity.glutenFree ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Dairy-Free: ",
          value: recipeDetailEntity.dairyFree ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Very Healthy: ",
          value: recipeDetailEntity.veryHealthy ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Cheap: ",
          value: recipeDetailEntity.cheap ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Very Popular: ",
          value: recipeDetailEntity.veryPopular ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Sustainable: ",
          value: recipeDetailEntity.sustainable ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Low FODMAP: ",
          value: recipeDetailEntity.lowFodmap ? "Yes" : "No",
        ),
        RecipeDetailRowItems(
          purpose: "Weight Watcher Points: ",
          value: "${recipeDetailEntity.weightWatcherSmartPoints}",
        ),
        RecipeDetailRowItems(purpose: "GAPS: ", value: recipeDetailEntity.gaps),
        RecipeDetailRowItems(
          purpose: "Health Score: ",
          value: recipeDetailEntity.healthScore.toString(),
        ),
        RecipeDetailRowItems(
          purpose: "Price Per Serving: ",
          value: "\Rs.${recipeDetailEntity.pricePerServing}",
        ),
      ],
    );
  }
}
