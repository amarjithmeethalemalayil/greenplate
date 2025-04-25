part of 'search_recipe_bloc.dart';

@immutable
sealed class SearchRecipeState {}

final class SearchRecipeInitial extends SearchRecipeState {}

class SearchRecipeLoading extends SearchRecipeState {}

class SearchRecipeLoaded extends SearchRecipeState {
  final List<RecipeEntity> recipes;

  SearchRecipeLoaded({required this.recipes});
}

class SearchRecipeError extends SearchRecipeState {
  final String message;

  SearchRecipeError({required this.message});
}
