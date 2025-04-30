import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/favourite/domain/repository/fetch_fav_recipes_repository.dart';

class FetchCurrentUserid {
  final FetchFavRecipesRepository fetchFavRecipesRepository;

  FetchCurrentUserid(this.fetchFavRecipesRepository);

  Future<Either<Failure, String>> call() async {
    return await fetchFavRecipesRepository.fetchUserId();
  }
}
