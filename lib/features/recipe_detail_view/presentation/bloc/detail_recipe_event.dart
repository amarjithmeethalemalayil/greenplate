part of 'detail_recipe_bloc.dart';

@immutable
sealed class DetailRecipeEvent {}

class FetchDetailRecipeEvent extends DetailRecipeEvent {
  final String id;

  FetchDetailRecipeEvent(this.id);
}

class SaveRecipeToFirebase extends DetailRecipeEvent {
  final RecipeEntity recipe;
  final RecipeDetailEntity recipeDetailEntity;
  final  String userId;

  SaveRecipeToFirebase({
    required this.recipe,
    required this.recipeDetailEntity,
    required this.userId,
  });
}
