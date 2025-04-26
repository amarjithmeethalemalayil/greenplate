// import 'dart:convert';
// import 'package:green_plate/core/error/app_exception.dart';
// import 'package:green_plate/core/model/recipe_model.dart';
// import 'package:http/http.dart' as http show Client;

// abstract interface class SearchRemoteDataSource {
//   Future<List<RecipeModel>> searchDish(String query);
// }

// class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
//   final http.Client client;
//   final String baseUrl;
//   final String apiKey;

//   SearchRemoteDataSourceImpl({
//     required this.client,
//     required this.baseUrl,
//     required this.apiKey,
//   });

//   @override
//   Future<List<RecipeModel>> searchDish(String query) async {
//     try {
//       final response = await client.get(
//         Uri.parse(
//           "$baseUrl/recipes/complexSearch?query=$query&maxFat=25&number=2&apiKey=$apiKey",
//         ),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         final results = data['results'] as List<dynamic>;
//         return results
//             .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
//             .toList();
//       } else {
//         throw ServerException('Failed to load recipes: ${response.statusCode}');
//       }
//     } on ServerException catch (e) {
//       throw ServerException(e.message);
//     } catch (e, st) {
//       throw ServerException(e.toString(), st);
//     }
//   }
// }
import 'dart:convert';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/recipe_model.dart';
import 'package:http/http.dart' as http;

abstract interface class SearchRemoteDataSource {
  Future<List<RecipeModel>> searchDish(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String apiKey;

  SearchRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiKey,
  });

  @override
  Future<List<RecipeModel>> searchDish(String query) async {
    try {
      final encodedQuery = Uri.encodeQueryComponent(query);
      final authority = baseUrl
          .replaceAll(RegExp(r'https?://'), '')
          .replaceAll(RegExp(r'/.*'), '');
      final uri = Uri.https(
        authority,
        '/recipes/complexSearch',
        {
          'apiKey': apiKey,
          'query': encodedQuery,
          'maxFat': '25',
          'number': '2',
        },
      );
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        return results
            .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'API Error (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e, st) {
      throw ServerException('Search failed: ${e.toString()}', st);
    }
  }
}