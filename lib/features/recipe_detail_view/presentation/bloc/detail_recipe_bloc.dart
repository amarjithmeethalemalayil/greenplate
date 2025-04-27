import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/get_datail_recipe.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/is_saved_in_firebase.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/save_recipe.dart';

part 'detail_recipe_event.dart';
part 'detail_recipe_state.dart';

class DetailRecipeBloc extends Bloc<DetailRecipeEvent, DetailRecipeState> {
  final GetDatailRecipe getDatailRecipe;
  final SaveRecipe saveRecipe;
  final IsSavedInFirebase isSavedInFirebase;

  DetailRecipeBloc(
    this.getDatailRecipe,
    this.saveRecipe,
    this.isSavedInFirebase,
  ) : super(DetailRecipeInitial()) {
    on<FetchDetailRecipeEvent>((event, emit) async {
      emit(DetailRecipeLoading());
      final result = await getDatailRecipe(event.id);
      final isSavedResult = await isSavedInFirebase(event.id);
      result.fold(
        (failure) {
          emit(DetailRecipeError(failure.message));
        },
        (recipe) {
          isSavedResult.fold(
            (failure) {
              emit(DetailRecipeLoaded(recipe, false));
            },
            (isSaved) {
              emit(DetailRecipeLoaded(recipe, isSaved));
            },
          );
        },
      );
    });

    on<SaveRecipeToFirebase>(
      (event, emit) async {
        final result = await saveRecipe(event.recipe);
        result.fold(
          (failure) => emit(DetailRecipeError(failure.message)),
          (res) => emit(RecipeSavedToFirebase(res, event.recipeDetailEntity)),
        );
      },
    );
  }
}
