import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/ai_recipe/domain/entity/ai_recipe_entity.dart';
import 'package:green_plate/features/ai_recipe/domain/repository/ai_recipe_repository.dart';

class GetAiRecipe {
  final AiRecipeRepository aiRecipeRepository;
  GetAiRecipe(this.aiRecipeRepository);
  Future<Either<Failure, AiRecipeEntity>> call(List<String> ingredients) async {
    return await aiRecipeRepository.fetchRecipeWithAi(ingredients);
  }
}
