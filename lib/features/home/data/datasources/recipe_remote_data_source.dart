import 'dart:convert';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RecipeRemoteDataSource {
  Future<List<RecipeModel>> fetchRecipes(String category);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String apiKey;

  RecipeRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiKey,
  });

  @override
  Future<List<RecipeModel>> fetchRecipes(String category) async {
    try {
      final response = await client.get(
        Uri.parse(
            '$baseUrl/complexSearch?query=$category&number=10&addRecipeInformation=true&apiKey=$apiKey'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        return results
            .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to load recipes: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e, st) {
      throw ServerException(e.toString(), st);
    }
  }
}
