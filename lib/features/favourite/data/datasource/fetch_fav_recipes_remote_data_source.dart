import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/model/recipe_model.dart';

abstract interface class FetchFavRecipesRemoteDataSource {
  Future<List<RecipeModel>> fetchFavRecipes(String userId);
  Future<void> deleteRecipeById(String documentId, String userId);
}

class FetchFavRecipesRemoteDataSourceImpl
    implements FetchFavRecipesRemoteDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  FetchFavRecipesRemoteDataSourceImpl({
    required this.db,
    required this.auth,
  });
  @override
  Future<List<RecipeModel>> fetchFavRecipes(String userId) async {
    try {
      final userDocId = userId == 'unknown' ? auth.currentUser?.uid : userId;
      if (userDocId == null || userDocId.isEmpty) {
        throw InvalidCredentialsFailure('Invalid user ID');
      }
      final snapshot = await db
          .collection(Keys.accountsCollection)
          .doc(userDocId)
          .collection(Keys.recipeCollection)
          .get();
      List<RecipeModel> recipes =
          snapshot.docs.map((doc) => RecipeModel.fromJson(doc.data())).toList();
      return recipes;
    } catch (e) {
      throw ServerException('Failed to fetch favorite recipes: $e');
    }
  }

  @override
  Future<void> deleteRecipeById(String documentId, String userId) async {
    try {
      final userDocId = userId == 'unknown' ? auth.currentUser?.uid : userId;
      if (userDocId == null || userDocId.isEmpty) {
        return;
      }
      await db
          .collection(Keys.accountsCollection)
          .doc(userId)
          .collection('recipes')
          .doc(documentId)
          .delete();
    } catch (e) {
      throw ServerException('Failed to delete recipe with ID $documentId: $e');
    }
  }
}
