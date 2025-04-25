import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';

abstract interface class SearchRecipeRepository {
  Future<Either<Failure, List<RecipeEntity>>> searchDish(String query);
}
