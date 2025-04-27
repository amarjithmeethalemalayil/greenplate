import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/favourite/domain/usecase/fetch_fav_recipes.dart';
import 'package:green_plate/features/favourite/domain/usecase/delete_fav_recipe.dart';

part 'fav_recipes_event.dart';
part 'fav_recipes_state.dart';

class FavRecipesBloc extends Bloc<FavRecipesEvent, FavRecipesState> {
  final FetchFavRecipes fetchFavRecipes;
  final DeleteFavRecipe deleteFavRecipe;

  FavRecipesBloc(
    this.fetchFavRecipes,
    this.deleteFavRecipe,
  ) : super(FavRecipesInitial()) {
    on<FetchFavRecipesEvent>((event, emit) async {
      emit(FavRecipesLoading());
      final result = await fetchFavRecipes();
      result.fold(
        (failure) => emit(FavRecipesError(failure.message)),
        (recipes) => emit(FavRecipesLoaded(recipes)),
      );
    });

    on<DeleteFavRecipeEvent>((event, emit) async {
      try {
        emit(FavRecipesLoading());
        await deleteFavRecipe(event.docId);
        final result = await fetchFavRecipes();
        result.fold(
          (failure) => emit(FavRecipesError(failure.message)),
          (recipes) => emit(FavRecipesLoaded(recipes)),
        );
      } catch (e) {
        emit(FavRecipesError('Failed to delete the recipe: $e'));
      }
    });
  }
}
