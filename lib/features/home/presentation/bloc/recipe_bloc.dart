import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/home/domain/usecases/fetch_name.dart';
import 'package:green_plate/features/home/domain/usecases/get_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipes getRecipes;
  final FetchName fetchName;

  RecipeBloc({
    required this.getRecipes,
    required this.fetchName,
  }) : super(RecipeInitial()) {
    on<FetchRecipes>(_onFetchRecipes);
    on<FetcUserhName>(_fetchName);
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

  Future<void> _fetchName(
    FetcUserhName event,
    Emitter<RecipeState> emit,
  ) async {
    emit(RecipeLoading());
    final result = await fetchName();
    result.fold(
      (faliure) => NameFetched("unknown"),
      (username) => NameFetched(username),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
