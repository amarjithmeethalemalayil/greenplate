part of 'meal_type_cubit.dart';

@immutable
abstract class MealTypeState {}

class MealTypeInitial extends MealTypeState {}

class MealTypeSelected extends MealTypeState {
  final int selectedMealIndex;

  MealTypeSelected(this.selectedMealIndex);
}
