part of 'fav_recipes_bloc.dart';

@immutable
sealed class FavRecipesState {}

final class FavRecipesInitial extends FavRecipesState {}

final class FavRecipesLoading extends FavRecipesState {}

final class FavRecipesLoaded extends FavRecipesState {
  final List<RecipeEntity> recipes;
  
  FavRecipesLoaded(this.recipes);
}

final class FavRecipesError extends FavRecipesState {
  final String message;

  FavRecipesError(this.message);
}
