import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';

abstract interface class FetchDetailRecipeRepository {
  Future<Either<Failure, RecipeDetailEntity>> fetchDetailRecipe(String id);
  Future<Either<Failure, bool>> saveRecipeToFirebase(
    RecipeEntity recipe,
    String userId,
  );
  Future<Either<Failure, bool>> isRecipeSavedInFirebase(String id,String userId);
  Future<Either<Failure, String>> getUserId();
}
