import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/recipe_detail_view/domain/repository/fetch_detail_recipe_repository.dart';

class FetchUserId {
  final FetchDetailRecipeRepository repository;

  FetchUserId(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getUserId();
  }
}
