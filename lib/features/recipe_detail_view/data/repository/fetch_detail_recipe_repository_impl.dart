import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/features/recipe_detail_view/data/datasources/detail_recipe_remote_data_source.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/domain/repository/fetch_detail_recipe_repository.dart';

class FetchDetailRecipeRepositoryImpl implements FetchDetailRecipeRepository {
  final DetailRecipeRemoteDataSource remoteDataSource;

  FetchDetailRecipeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, RecipeDetailEntity>> fetchDetailRecipe(
      String id) async {
    try {
      final result = await remoteDataSource.fetchRecipes(id);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
