part of 'detail_recipe_bloc.dart';

@immutable
sealed class DetailRecipeState {}

final class DetailRecipeInitial extends DetailRecipeState {}

class DetailRecipeLoading extends DetailRecipeState {}

class DetailRecipeLoaded extends DetailRecipeState {
  final RecipeDetailEntity recipe;
  final bool isSaved;
  final String userId;
  DetailRecipeLoaded(
    this.recipe,
    this.isSaved,
    this.userId,
  );
}

class RecipeSavedToFirebase extends DetailRecipeState {
  final bool isSaved;
  final RecipeDetailEntity recipeDetailEntity;

  RecipeSavedToFirebase(this.isSaved, this.recipeDetailEntity);
}

class DetailRecipeError extends DetailRecipeState {
  final String message;

  DetailRecipeError(this.message);
}
