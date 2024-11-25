import 'dart:convert';

import 'package:yumly/models/meal_models.dart';
import 'package:http/http.dart' as http;

class MealRepository {
  // Fetch a random meal (existing method)
  Future<MealModel> getMeal() async {
    String url = "https://www.themealdb.com/api/json/v1/1/random.php";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return MealModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load random meal');
    }
  }

  // Fetch meals filtered by category or all meals if the category is empty
Future<List<MealModel>> getMealsByCategory(String category) async {
  String url = category.isEmpty || category == "All"
      ? "https://www.themealdb.com/api/json/v1/1/search.php?s=" // Fetch all meals
      : "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category"; // Fetch by category

  Uri uri = Uri.parse(url);
  http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    final dynamic jsonResponse = jsonDecode(response.body);
    final List<dynamic>? meals = jsonResponse['meals'];

    if (meals == null) {
      // Handle the case where no meals are found
      return [];
    }

    if (category.isEmpty || category == "All") {
      // Parse detailed meals (response from `search.php?s=`)
      return meals.map((meal) => MealModel.fromJson({'meals': [meal]})).toList();
    }

    // Parse filtered meals (response from `filter.php?c=`)
    return meals.map((meal) => MealModel.fromFilteredJson(meal)).toList();
  } else {
    throw Exception('Failed to load meals');
  }
}

  // Search meals by name
  Future<List<MealModel>> searchMealsByName(String query) async {
    String url = "https://www.themealdb.com/api/json/v1/1/search.php?s=$query";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> meals = jsonDecode(response.body)['meals'] ?? [];
      return meals.map((meal) => MealModel.fromFilteredJson(meal)).toList();
    } else {
      throw Exception('Failed to search meals by name');
    }
  }
}
