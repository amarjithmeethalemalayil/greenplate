import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/search_dish/domain/repository/search_recipe_repository.dart';

class SearchDish {
  final SearchRecipeRepository searchRecipeRepository;

  SearchDish(this.searchRecipeRepository);
  Future<Either<Failure, List<RecipeEntity>>> call(String query) async {
    return await searchRecipeRepository.searchDish(query);
  }
}
