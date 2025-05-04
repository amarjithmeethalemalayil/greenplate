import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:green_plate/features/recipe_detail_view/data/datasources/detail_recipe_remote_data_source.dart';
import 'package:green_plate/core/datasource/fetch_userid_local_datasource.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/repository/fetch_detail_recipe_repository.dart';

class FetchDetailRecipeRepositoryImpl implements FetchDetailRecipeRepository {
  final DetailRecipeRemoteDataSource remoteDataSource;
  final FetchUseridLocalDatasource fetchUseridLocalDatasource;

  FetchDetailRecipeRepositoryImpl(
      this.remoteDataSource, this.fetchUseridLocalDatasource);

  @override
  Future<Either<Failure, RecipeDetailEntity>> fetchDetailRecipe(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.fetchRecipes(id);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveRecipeToFirebase(
    RecipeEntity recipe,
    String userId,
  ) async {
    final recipeModel = RecipeModel.fromEntity(recipe);
    try {
      final res = await remoteDataSource.saveRecipeToFIrestore(recipeModel, userId);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isRecipeSavedInFirebase(String id,String userId) async {
    try {
      final isSaved = await remoteDataSource.isRecipeSavedInFirebase(id,userId);
      return right(isSaved);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getUserId() async {
    try {
      final name = await fetchUseridLocalDatasource.fetchUserId();
      return right(name);
    } catch (e, st) {
      return left(UnknownFailure(e.toString(), st));
    }
  }
}
