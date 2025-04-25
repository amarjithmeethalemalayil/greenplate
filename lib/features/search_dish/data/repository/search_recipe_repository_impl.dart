import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:green_plate/features/search_dish/data/datasource/search_remote_data_source.dart';
import 'package:green_plate/features/search_dish/domain/repository/search_recipe_repository.dart';

class SearchRecipeRepositoryImpl implements SearchRecipeRepository {
  final SearchRemoteDataSource repository;

  SearchRecipeRepositoryImpl(this.repository);

  @override
  Future<Either<Failure, List<RecipeModel>>> searchDish(String query) async {
    try {
      final recipes = await repository.searchDish(query);
      return right(recipes);
    } on ServerException catch (e, st) {
      return left(ServerFailure(e.message, st));
    } catch (e, st) {
      return left(ServerFailure(e.toString(), st));
    }
  }
}
