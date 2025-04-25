import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/repository/fetch_detail_recipe_repository.dart';


class GetDatailRecipe {
  final FetchDetailRecipeRepository repository;

  GetDatailRecipe(this.repository);

  Future<Either<Failure, RecipeDetailEntity>> call(String id) async {
    return await repository.fetchDetailRecipe(id);
  }
}