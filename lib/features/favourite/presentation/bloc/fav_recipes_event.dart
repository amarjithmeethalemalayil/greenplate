part of 'fav_recipes_bloc.dart';

@immutable
sealed class FavRecipesEvent {}

class FetchFavRecipesEvent extends FavRecipesEvent {}

class DeleteFavRecipeEvent extends FavRecipesEvent {
  final String docId;

  DeleteFavRecipeEvent(this.docId);
}
