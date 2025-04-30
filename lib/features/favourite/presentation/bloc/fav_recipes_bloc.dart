import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/favourite/domain/usecase/fetch_current_userid.dart';
import 'package:green_plate/features/favourite/domain/usecase/fetch_fav_recipes.dart';
import 'package:green_plate/features/favourite/domain/usecase/delete_fav_recipe.dart';

part 'fav_recipes_event.dart';
part 'fav_recipes_state.dart';

class FavRecipesBloc extends Bloc<FavRecipesEvent, FavRecipesState> {
  final FetchFavRecipes fetchFavRecipes;
  final DeleteFavRecipe deleteFavRecipe;
  final FetchCurrentUserid fetchCurrentUserid;

  FavRecipesBloc(
    this.fetchFavRecipes,
    this.deleteFavRecipe,
    this.fetchCurrentUserid,
  ) : super(FavRecipesInitial()) {
    on<FetchFavRecipesEvent>((event, emit) async {
      emit(FavRecipesLoading());
      final response = await fetchCurrentUserid();
      final userid = response.fold(
        ((failure) => "unknown"),
        (userId) => userId,
      );
      final result = await fetchFavRecipes(userid);
      result.fold(
        (failure) => emit(FavRecipesError(failure.message)),
        (recipes) => emit(FavRecipesLoaded(recipes)),
      );
    });

    on<DeleteFavRecipeEvent>((event, emit) async {
      emit(FavRecipesLoading());
      final response = await fetchCurrentUserid();
      final userid = response.fold(
        ((failure) => "unknown"),
        (userId) => userId,
      );
      await deleteFavRecipe(event.docId, userid);
      final result = await fetchFavRecipes(userid);
      result.fold(
        (failure) => emit(FavRecipesError(failure.message)),
        (recipes) => emit(FavRecipesLoaded(recipes)),
      );
    });
  }
}
