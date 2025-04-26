part of 'ai_recipe_list_cubit.dart';

@immutable
sealed class AiRecipeListState {}

final class AiRecipeListInitial extends AiRecipeListState {}

final class AiRecipeListLoaded extends AiRecipeListState {
  final List<Map<String, dynamic>> ingredients;
  
  AiRecipeListLoaded(this.ingredients);
}

final class AiRecipeListError extends AiRecipeListState {
  final String message;
  
  AiRecipeListError(this.message);
}