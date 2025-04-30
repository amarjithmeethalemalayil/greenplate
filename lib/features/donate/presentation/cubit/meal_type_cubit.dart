import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'meal_type_state.dart';

class MealTypeCubit extends Cubit<MealTypeState> {
  MealTypeCubit() : super(MealTypeInitial());

  void selectMealType(int index) {
    emit(MealTypeSelected(index));
  }
}
