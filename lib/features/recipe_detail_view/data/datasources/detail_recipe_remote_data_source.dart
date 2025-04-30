import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:green_plate/features/recipe_detail_view/data/model/recipe_detail_model.dart';
import 'package:http/http.dart' as http;

abstract interface class DetailRecipeRemoteDataSource {
  Future<RecipeDetailModel> fetchRecipes(String id);
  Future<bool> saveRecipeToFIrestore(RecipeModel recipe, String userId);
  Future<bool> isRecipeSavedInFirebase(String id, String userId);
}

class DetailRecipeRemoteDataSourceImpl implements DetailRecipeRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String apiKey;
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  DetailRecipeRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiKey,
    required this.db,
    required this.auth,
  });

  @override
  Future<RecipeDetailModel> fetchRecipes(String id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$id/information?apiKey=$apiKey'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return RecipeDetailModel.fromJson(data);
      } else {
        throw ServerException('Failed to load recipe: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e, st) {
      throw ServerException(e.toString(), st);
    }
  }

  @override
  Future<bool> saveRecipeToFIrestore(RecipeModel recipe, String userId) async {
    try {
      final userDocId = userId == 'unknown' ? auth.currentUser?.uid : userId;
      if (userDocId == null || userDocId.isEmpty) {
        return false;
      }
      final recipeJson = recipe.toJson();
      final docId = recipe.id.toString();
      await db
          .collection(Keys.accountsCollection)
          .doc(userDocId)
          .collection(Keys.recipeCollection)
          .doc(docId)
          .set(recipeJson);
      return true;
    } on FirebaseException catch (e) {
      throw ServerException('Failed to save recipe to Firestore: ${e.message}');
    } catch (e, st) {
      throw ServerException(
        'An error occurred while saving the recipe: ${e.toString()}',
        st,
      );
    }
  }

  @override
  Future<bool> isRecipeSavedInFirebase(String id, String userId) async {
    try {
      final userDocId = userId == 'unknown' ? auth.currentUser?.uid : userId;
      if (userDocId == null || userDocId.isEmpty) {
        return false;
      }
      final docSnapshot = await db
          .collection(Keys.accountsCollection)
          .doc(userId)
          .collection(Keys.recipeCollection)
          .doc(id)
          .get();
      return docSnapshot.exists;
    } on FirebaseException catch (e) {
      throw ServerException(
        'Failed to check if the recipe exists in Firestore: ${e.message}',
      );
    } catch (e, st) {
      throw ServerException(
        'An error occurred while checking the recipe in Firestore: ${e.toString()}',
        st,
      );
    }
  }
}
