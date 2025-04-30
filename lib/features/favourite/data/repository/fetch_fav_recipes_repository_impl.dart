import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/datasource/fetch_userid_local_datasource.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:green_plate/features/favourite/data/datasource/fetch_fav_recipes_remote_data_source.dart';
import 'package:green_plate/features/favourite/domain/repository/fetch_fav_recipes_repository.dart';

class FetchFavRecipesRepositoryImpl implements FetchFavRecipesRepository {
  final FetchFavRecipesRemoteDataSource remoteDataSource;
  final FetchUseridLocalDatasource fetchUseridLocalDatasource;

  FetchFavRecipesRepositoryImpl(
      this.remoteDataSource, this.fetchUseridLocalDatasource);

  @override
  Future<Either<Failure, List<RecipeModel>>> fetchFavouriteRecipes(
    String userId,
  ) async {
    try {
      final recipes = await remoteDataSource.fetchFavRecipes(userId);
      return right(recipes);
    } catch (e) {
      return left(ServerFailure('Failed to fetch favorite recipes: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavRecipe(
    String docId,
    String userId,
  ) async {
    try {
      await remoteDataSource.deleteRecipeById(docId, userId);
      return Right(null);
    } catch (e) {
      return left(ServerFailure('Failed to delete favorite recipe: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> fetchUserId() async {
    try {
      final name = await fetchUseridLocalDatasource.fetchUserId();
      return right(name);
    } catch (e, st) {
      return left(UnknownFailure(e.toString(), st));
    }
  }
}
