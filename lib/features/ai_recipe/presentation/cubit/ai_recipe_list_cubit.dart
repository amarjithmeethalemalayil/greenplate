// ai_recipe_list_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

part 'ai_recipe_list_state.dart';

class AiRecipeListCubit extends Cubit<AiRecipeListState> {
  AiRecipeListCubit() : super(AiRecipeListInitial());

  void addIngredient(String name) {
    try {
      final currentState = state;
      if (name.trim().isEmpty) return;
      
      if (currentState is AiRecipeListLoaded) {
        if (currentState.ingredients.any((item) => item['name'] == name.trim())) {
          return;
        }
        
        final newIngredient = {
          'name': name.trim(),
          'color': _getRandomColor(),
        };
        
        emit(AiRecipeListLoaded([...currentState.ingredients, newIngredient]));
      } else {
        final newIngredient = {
          'name': name.trim(),
          'color': _getRandomColor(),
        };
        
        emit(AiRecipeListLoaded([newIngredient]));
      }
    } catch (e) {
      emit(AiRecipeListError('Failed to add ingredient'));
    }
  }

  void removeIngredient(int index) {
    try {
      final currentState = state;
      if (currentState is! AiRecipeListLoaded) return;
      
      final newIngredients = List<Map<String, dynamic>>.from(currentState.ingredients);
      newIngredients.removeAt(index);
      
      if (newIngredients.isEmpty) {
        emit(AiRecipeListInitial());
      } else {
        emit(AiRecipeListLoaded(newIngredients));
      }
    } catch (e) {
      emit(AiRecipeListError('Failed to remove ingredient'));
    }
  }

  Color _getRandomColor() {
    final random = DateTime.now().millisecond % MyColors.aiListRandomColors.length;
    return MyColors.aiListRandomColors[random];
  }
}