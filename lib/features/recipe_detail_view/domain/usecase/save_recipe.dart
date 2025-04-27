import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/recipe_detail_view/domain/repository/fetch_detail_recipe_repository.dart';

class SaveRecipe {
  final FetchDetailRecipeRepository repository;

  SaveRecipe(this.repository);

  Future<Either<Failure, bool>> call(RecipeEntity recipe) async {
    return await repository.saveRecipeToFirebase(recipe);
  }
}
