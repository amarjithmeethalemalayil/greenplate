import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';

abstract interface class FetchDetailRecipeRepository {
  Future<Either<Failure, RecipeDetailEntity>> fetchDetailRecipe(String id);
}
