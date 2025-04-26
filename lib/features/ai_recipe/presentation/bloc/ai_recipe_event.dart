part of 'ai_recipe_bloc.dart';

@immutable
sealed class AiRecipeEvent {}

class FetchAiRecipeEvent extends AiRecipeEvent {
  final List<String> ingredients;

  FetchAiRecipeEvent(this.ingredients);
}
