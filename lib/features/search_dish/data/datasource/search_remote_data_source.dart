import 'dart:convert';

import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:http/http.dart' as http show Client;

abstract interface class SearchRemoteDataSource {
  Future<List<RecipeModel>> searchDish(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;
  final String baseUrl; // Should be "https://api.spoonacular.com"
  final String apiKey; // Ensure this is valid

  SearchRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiKey,
  });

  @override
  Future<List<RecipeModel>> searchDish(String query) async {
    try {
      // 1. Construct the URL properly using Uri.https()
      final uri = Uri.https(
        "api.spoonacular.com", // authority
        "/recipes/complexSearch", // path
        {
          // query parameters
          "query": query,
          "apiKey": apiKey,
          "number": "10", // limit results
        },
      );

      print("Making request to: ${uri.toString()}");

      // 2. Make the request
      final response = await client.get(uri);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      // 3. Handle the response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final results =
            data['results'] as List<dynamic>; // Now 'results' is defined

        return results
            .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'API Error ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e, st) {
      print("Full error details: $e");
      print("Stack trace: $st");
      throw ServerException('Search failed: $e', st);
    }
  }
  // @override
  // Future<List<RecipeModel>> searchDish(String query) async {
  //   try {
  //     // Construct the correct URL (with /recipes/complexSearch)
  //     final uri = Uri.parse(
  //       "$baseUrl/recipes/complexSearch?query=$query&apiKey=$apiKey",
  //     );

  //     final response = await client.get(uri);

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body) as Map<String, dynamic>;
  //       final results = data['results'] as List<dynamic>;
  //       return results
  //           .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
  //           .toList();
  //     } else {
  //       throw ServerException(
  //         'Failed to load recipes (HTTP ${response.statusCode}): ${response.body}',
  //       );
  //     }
  //   } catch (e, st) {
  //     throw ServerException('Search failed: $e', st);
  //   }
  // }
}
