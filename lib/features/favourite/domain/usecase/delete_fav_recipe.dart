import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/favourite/domain/repository/fetch_fav_recipes_repository.dart';

class DeleteFavRecipe {
    final FetchFavRecipesRepository favRecipesRepository;
  DeleteFavRecipe(this.favRecipesRepository);

  Future<Either<Failure, void>> call(String docId) async {
    return favRecipesRepository.deleteFavRecipe(docId);
  }
}