import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/features/home/data/datasources/fetch_name_local_datasource.dart';
import 'package:green_plate/features/home/domain/repository/recipe_repository.dart';
import '../datasources/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final FetchNameLocalDatasource fetchNameLocalDatasource;

  RecipeRepositoryImpl(this.remoteDataSource, this.fetchNameLocalDatasource);

  @override
  Future<Either<Failure, List<RecipeEntity>>> fetchRecipes(
      String category) async {
    try {
      final recipes = await remoteDataSource.fetchRecipes(category);
      return right(recipes);
    } on ServerException catch (e, st) {
      return left(ServerFailure(e.message, st));
    } catch (e, st) {
      return left(ServerFailure(e.toString(), st));
    }
  }

  @override
  Future<Either<Failure, String>> fetchName() async {
    try {
      final name = await fetchNameLocalDatasource.fetchUserName();
      return right(name);
    } catch (e, st) {
      return left(UnknownFailure(e.toString(), st));
    }
  }
}
