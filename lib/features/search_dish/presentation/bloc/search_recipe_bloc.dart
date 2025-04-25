import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/search_dish/domain/usecase/search_dish.dart';

part 'search_recipe_event.dart';
part 'search_recipe_state.dart';

class SearchRecipeBloc extends Bloc<SearchRecipeEvent, SearchRecipeState> {
  final SearchDish searchDish;

  SearchRecipeBloc({required this.searchDish}) : super(SearchRecipeInitial()) {
    on<SearchRecipeRequested>(_onSearchRecipeRequested);
  }

  Future<void> _onSearchRecipeRequested(
    SearchRecipeRequested event,
    Emitter<SearchRecipeState> emit,
  ) async {
    emit(SearchRecipeLoading());
    final result = await searchDish(event.query);
    result.fold(
      (failure) {
        emit(SearchRecipeError(message: _mapFailureToMessage(failure)));
      },
      (recipes) {
        emit(
          SearchRecipeLoaded(recipes: recipes),
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error: ${failure.message}';
    } else {
      return 'An unexpected error occurred';
    }
  }
}
