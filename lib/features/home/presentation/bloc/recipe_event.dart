part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class FetchRecipes extends RecipeEvent {
  final String category;

  FetchRecipes(this.category);
}

class FetcUserhName extends RecipeEvent{}

