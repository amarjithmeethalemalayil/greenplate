import 'dart:convert';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/features/ai_recipe/data/model/ai_recipe_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AiRecipeGeneratorRemoteDataSource {
  Future<AiRecipeModel> findRecipesByIngredients(List<String> ingredients);
}

class AiRecipeGeneratorRemoteDataSourceImpl
    implements AiRecipeGeneratorRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String apiKey;

  AiRecipeGeneratorRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiKey,
  });

  @override
  Future<AiRecipeModel> findRecipesByIngredients(
      List<String> ingredients) async {
    try {
      final authority = baseUrl
          .replaceAll(RegExp(r'https?://'), '')
          .replaceAll(RegExp(r'/.*'), '');

      final uri = Uri.https(
        authority,
        '/recipes/findByIngredients',
        {
          'apiKey': apiKey,
          'ingredients': ingredients.join(','),
          'number': '5',
          'ranking': '1',
          'ignorePantry': 'true',
        },
      );
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isNotEmpty) {
          return AiRecipeModel.fromJson(data.first as Map<String, dynamic>);
        } else {
          throw ServerException('No recipes found.');
        }
      } else {
        throw ServerException(
          'API Error (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e, st) {
      throw ServerException('Recipe search failed: ${e.toString()}', st);
    }
  }
}
