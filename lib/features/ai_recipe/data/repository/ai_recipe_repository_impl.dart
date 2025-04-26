import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/ai_recipe/data/datasource/ai_recipe_generator_remote_data_source.dart';
import 'package:green_plate/features/ai_recipe/data/model/ai_recipe_model.dart';
import 'package:green_plate/features/ai_recipe/domain/repository/ai_recipe_repository.dart';

class AiRecipeRepositoryImpl implements AiRecipeRepository {
  final AiRecipeGeneratorRemoteDataSource aiRecipeGeneratorRemoteDataSource;
  
  AiRecipeRepositoryImpl(this.aiRecipeGeneratorRemoteDataSource);

  @override
  Future<Either<Failure, AiRecipeModel>> fetchRecipeWithAi(
      List<String> ingredients) async {
    try {
      final aiRecipe = await aiRecipeGeneratorRemoteDataSource
          .findRecipesByIngredients(ingredients);
      return Right(aiRecipe);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
