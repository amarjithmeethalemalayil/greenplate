import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/fetch_userid.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/get_datail_recipe.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/is_saved_in_firebase.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/save_recipe.dart';

part 'detail_recipe_event.dart';
part 'detail_recipe_state.dart';

class DetailRecipeBloc extends Bloc<DetailRecipeEvent, DetailRecipeState> {
  final GetDatailRecipe getDatailRecipe;
  final SaveRecipe saveRecipe;
  final IsSavedInFirebase isSavedInFirebase;
  final FetchUserId fetchUserId;

  DetailRecipeBloc(
    this.getDatailRecipe,
    this.saveRecipe,
    this.isSavedInFirebase,
    this.fetchUserId,
  ) : super(DetailRecipeInitial()) {
    on<FetchDetailRecipeEvent>((event, emit) async {
      emit(DetailRecipeLoading());
      try {
        final recipeResult = await getDatailRecipe(event.id);
        final recipe = recipeResult.fold(
          (failure) => throw failure,
          (recipe) => recipe,
        );
        final userIdResult = await fetchUserId();
        final userId = userIdResult.fold(
          (failure) => 'unknown',
          (id) => id,
        );
        final isSavedResult = await isSavedInFirebase(event.id, userId);
        final isSaved = isSavedResult.fold(
          (failure) => false,
          (saved) => saved,
        );
        emit(DetailRecipeLoaded(recipe, isSaved, userId));
      } catch (e) {
        emit(DetailRecipeError(e.toString()));
      }
    });

    on<SaveRecipeToFirebase>(
      (event, emit) async {
        final result = await saveRecipe(event.recipe, event.userId);
        result.fold(
          (failure) => emit(DetailRecipeError(failure.message)),
          (res) => emit(RecipeSavedToFirebase(res, event.recipeDetailEntity)),
        );
      },
    );
  }
}
