import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/home/domain/repository/recipe_repository.dart';

class FetchName {
  final RecipeRepository recipeRepository;

  FetchName(this.recipeRepository);

  Future<Either<Failure, String>> call() async {
    return await recipeRepository.fetchName();
  }
}