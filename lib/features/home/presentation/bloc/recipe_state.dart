part of 'recipe_bloc.dart';

sealed class RecipeState {
  const RecipeState();
}

final class RecipeInitial extends RecipeState {}

final class RecipeLoading extends RecipeState {}

final class RecipeLoaded extends RecipeState {
  final List<RecipeEntity> recipes;

  const RecipeLoaded(this.recipes);
}

final class RecipeError extends RecipeState {
  final String message;

  const RecipeError(
    this.message,
  );
}
