import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';

abstract interface class FetchFavRecipesRepository {
  Future<Either<Failure, List<RecipeEntity>>> fetchFavouriteRecipes(
    String userId,
  );
  Future<Either<Failure, void>> deleteFavRecipe(String userId, String docId);
  Future<Either<Failure, String>> fetchUserId();
}
