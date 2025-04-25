part of 'search_recipe_bloc.dart';

@immutable
sealed class SearchRecipeEvent {}

class SearchRecipeRequested extends SearchRecipeEvent {
  final String query;

  SearchRecipeRequested({required this.query});
}