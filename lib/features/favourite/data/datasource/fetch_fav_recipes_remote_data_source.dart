import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/recipe_model.dart';

abstract interface class FetchFavRecipesRemoteDataSource {
  Future<List<RecipeModel>> fetchFavRecipes();
  Future<void> deleteRecipeById(String documentId);
}

class FetchFavRecipesRemoteDataSourceImpl
    implements FetchFavRecipesRemoteDataSource {
  final FirebaseFirestore db;
  
  FetchFavRecipesRemoteDataSourceImpl({
    required this.db,
  });
  @override
  Future<List<RecipeModel>> fetchFavRecipes() async {
    try {
      final snapshot = await db.collection('recipes').get();
      List<RecipeModel> recipes =
          snapshot.docs.map((doc) => RecipeModel.fromJson(doc.data())).toList();
      return recipes;
    } catch (e) {
      throw ServerException('Failed to fetch favorite recipes: $e');
    }
  }

  @override
  Future<void> deleteRecipeById(String documentId) async {
    try {
      await db.collection('recipes').doc(documentId).delete();
    } catch (e) {
      throw ServerException('Failed to delete recipe with ID $documentId: $e');
    }
  }
}
