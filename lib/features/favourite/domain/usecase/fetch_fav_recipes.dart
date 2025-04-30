import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/favourite/domain/repository/fetch_fav_recipes_repository.dart';

class FetchFavRecipes {
  final FetchFavRecipesRepository favRecipesRepository;
  FetchFavRecipes(this.favRecipesRepository);

  Future<Either<Failure, List<RecipeEntity>>> call(String userId) async {
    return favRecipesRepository.fetchFavouriteRecipes(userId);
  }
}