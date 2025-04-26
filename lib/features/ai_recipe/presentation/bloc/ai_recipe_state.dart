part of 'ai_recipe_bloc.dart';

@immutable
sealed class AiRecipeState {}

final class AiRecipeInitial extends AiRecipeState {}

class AiRecipeLoading extends AiRecipeState {}

class AiRecipeLoaded extends AiRecipeState {
  final AiRecipeEntity aiRecipe;

  AiRecipeLoaded(this.aiRecipe);
}

class AiRecipeError extends AiRecipeState {
  final String message;

  AiRecipeError(this.message);
}
