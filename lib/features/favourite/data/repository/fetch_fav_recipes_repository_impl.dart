import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:green_plate/features/favourite/data/datasource/fetch_fav_recipes_remote_data_source.dart';
import 'package:green_plate/features/favourite/domain/repository/fetch_fav_recipes_repository.dart';

class FetchFavRecipesRepositoryImpl implements FetchFavRecipesRepository {
  final FetchFavRecipesRemoteDataSource remoteDataSource;

  FetchFavRecipesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<RecipeModel>>> fetchFavouriteRecipes() async {
    try {
      final recipes = await remoteDataSource.fetchFavRecipes();
      return right(recipes);
    } catch (e) {
      return left(ServerFailure('Failed to fetch favorite recipes: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavRecipe(String docId) async {
    try {
      await remoteDataSource.deleteRecipeById(docId);
      return Right(null);
    } catch (e) {
      return left(ServerFailure('Failed to delete favorite recipe: $e'));
    }
  }
}
