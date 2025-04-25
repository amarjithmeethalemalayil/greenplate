import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/home/domain/usecases/get_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipes getRecipes;

  RecipeBloc({required this.getRecipes}) : super(RecipeInitial()) {
    on<FetchRecipes>(_onFetchRecipes);
  }

  Future<void> _onFetchRecipes(
    FetchRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    emit(RecipeLoading());

    final result = await getRecipes(event.category);

    result.fold(
      (failure) => emit(RecipeError(_mapFailureToMessage(failure))),
      (recipes) => emit(RecipeLoaded(recipes)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
