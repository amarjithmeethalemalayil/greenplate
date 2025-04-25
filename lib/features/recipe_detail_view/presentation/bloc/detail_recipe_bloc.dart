import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/get_datail_recipe.dart';

part 'detail_recipe_event.dart';
part 'detail_recipe_state.dart';

class DetailRecipeBloc extends Bloc<DetailRecipeEvent, DetailRecipeState> {
  final GetDatailRecipe repository;

  DetailRecipeBloc(this.repository) : super(DetailRecipeInitial()) {
    on<FetchDetailRecipeEvent>((event, emit) async {
      emit(DetailRecipeLoading());
      final result = await repository(event.id);
      result.fold(
        (failure) => emit(DetailRecipeError(failure.message)),
        (recipe) => emit(DetailRecipeLoaded(recipe)),
      );
    });
  }
}
