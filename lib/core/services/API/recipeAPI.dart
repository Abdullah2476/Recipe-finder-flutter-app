// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

// Usage:

final String apiKey = '76b42fc81f964345bd1be98823d76bcd';
Future<dynamic> getrecipe() async {
  final response = await http.get(
    Uri.parse(
      "https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&number=100",
    ),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['results']; // Return just the results list
  } else {
    throw Exception('Failed to load recipes: ${response.statusCode}');
  }
}

Future<dynamic> getdetailRecipe(int recipeId) async {
  final response = await http.get(
    Uri.parse(
      "https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey",
    ),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load recipe details: ${response.statusCode}');
  }
}

Future<dynamic> searchRecipe(String ingredients) async {
  final response = await http.get(
    Uri.parse(
      'https://api.spoonacular.com/recipes/findByIngredients?apiKey=$apiKey&ingredients=$ingredients',
    ),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to search recipes: ${response.statusCode}');
  }
}
