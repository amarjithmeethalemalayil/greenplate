import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:green_plate/features/recipe_detail_view/data/model/recipe_detail_model.dart';
import 'package:http/http.dart' as http;

abstract interface class DetailRecipeRemoteDataSource {
  Future<RecipeDetailModel> fetchRecipes(String id);
  Future<bool> saveRecipeToFIrestore(RecipeModel recipe);
  Future<bool> isRecipeSavedInFirebase(String id);
}

class DetailRecipeRemoteDataSourceImpl implements DetailRecipeRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String apiKey;
  final FirebaseFirestore db;

  DetailRecipeRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiKey,
    required this.db,
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
  Future<bool> saveRecipeToFIrestore(RecipeModel recipe) async {
    try {
      final recipeJson = recipe.toJson();
      final docId = recipe.id.toString();
      await db.collection('recipes').doc(docId).set(recipeJson);
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
  Future<bool> isRecipeSavedInFirebase(String id) async {
    try {
      final docSnapshot = await db.collection('recipes').doc(id).get();
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
