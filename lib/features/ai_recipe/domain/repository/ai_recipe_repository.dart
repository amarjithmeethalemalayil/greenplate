import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/ai_recipe/domain/entity/ai_recipe_entity.dart';

abstract interface class AiRecipeRepository {
  Future<Either<Failure, AiRecipeEntity>> fetchRecipeWithAi(
      List<String> ingredients);
}
