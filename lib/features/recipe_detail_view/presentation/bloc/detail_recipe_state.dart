part of 'detail_recipe_bloc.dart';

@immutable
sealed class DetailRecipeState {}

final class DetailRecipeInitial extends DetailRecipeState {}

class DetailRecipeLoading extends DetailRecipeState {}

class DetailRecipeLoaded extends DetailRecipeState {
  final RecipeDetailEntity recipe;

  DetailRecipeLoaded(this.recipe);
}

class DetailRecipeError extends DetailRecipeState {
  final String message;

  DetailRecipeError(this.message);
}
