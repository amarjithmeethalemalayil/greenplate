// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalDataService {
//   final SharedPreferences prefs;
//   LocalDataService({required this.prefs});

//   Future<void> saveBool(String key, bool value) async {
//     await prefs.setBool(key, value);
//   }

//   Future<bool?> getBool(String key) async {
//     return prefs.getBool(key);
//   }

//   Future<void> deleteBool(String key) async {
//     await prefs.remove(key);
//   }

//   Future<void> saveUserJson(String key, Map<String, dynamic> userJson) async {
//     String userString = json.encode(userJson);
//     await prefs.setString(key, userString);
//   }

//   Future<Map<String, dynamic>?> getUserJson(String key) async {
//     String? userString = prefs.getString(key);
//     if (userString != null) {
//       return json.decode(userString);
//     }
//     return null;
//   }

//   Future<void> deleteUserJson(String key) async {
//     await prefs.remove(key);
//   }
// }
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataService {
  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Get a boolean value
  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // Delete a boolean value
  Future<void> deleteBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Save a user as JSON (using a Map<String, dynamic>)
  Future<void> saveUserJson(String key, Map<String, dynamic> userJson) async {
    final prefs = await SharedPreferences.getInstance();
    String userString = json.encode(userJson);
    await prefs.setString(key, userString);
  }

  // Get the user JSON
  Future<Map<String, dynamic>?> getUserJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(key);
    if (userString != null) {
      return json.decode(userString);
    }
    return null;
  }

  // Delete the user JSON
  Future<void> deleteUserJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
