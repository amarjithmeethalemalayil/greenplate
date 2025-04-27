import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/recipe_detail_view/domain/repository/fetch_detail_recipe_repository.dart';

class IsSavedInFirebase {
  final FetchDetailRecipeRepository repository;

  IsSavedInFirebase(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    return await repository.isRecipeSavedInFirebase(id);
  }
}
