import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/home/domain/repository/recipe_repository.dart';


class GetRecipes {
  final RecipeRepository repository;

  GetRecipes(this.repository);

  Future<Either<Failure, List<RecipeEntity>>> call(String category) async {
    return await repository.fetchRecipes(category);
  }
}