import 'dart:convert';

import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/features/recipe_detail_view/data/model/recipe_detail_model.dart';
import 'package:http/http.dart' as http;

abstract interface class DetailRecipeRemoteDataSource {
  Future<RecipeDetailModel> fetchRecipes(String id);
}

class DetailRecipeRemoteDataSourceImpl implements DetailRecipeRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String apiKey;

  DetailRecipeRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiKey,
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
}
