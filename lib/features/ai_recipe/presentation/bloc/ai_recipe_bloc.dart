import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/features/ai_recipe/domain/entity/ai_recipe_entity.dart';
import 'package:green_plate/features/ai_recipe/domain/usecase/get_ai_recipe.dart';

part 'ai_recipe_event.dart';
part 'ai_recipe_state.dart';

class AiRecipeBloc extends Bloc<AiRecipeEvent, AiRecipeState> {
  final GetAiRecipe getAiRecipe;

  AiRecipeBloc(this.getAiRecipe) : super(AiRecipeInitial()) {
    on<FetchAiRecipeEvent>(_onFetchAiRecipe);
  }

  Future<void> _onFetchAiRecipe(
    FetchAiRecipeEvent event,
    Emitter<AiRecipeState> emit,
  ) async {
    emit(AiRecipeLoading());
    final result = await getAiRecipe(event.ingredients);
    result.fold(
      (failure) => emit(AiRecipeError(failure.message)),
      (aiRecipe) => emit(AiRecipeLoaded(aiRecipe)),
    );
  }
}