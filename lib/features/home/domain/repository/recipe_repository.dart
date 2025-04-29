import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';

abstract interface class RecipeRepository {
  Future<Either<Failure, List<RecipeEntity>>> fetchRecipes(String category);
  Future<Either<Failure, String>> fetchName();
}
