import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/models/meal_models.dart';
import 'package:yumly/repository/meal_repository.dart';

// Provider to fetch a random meal (used by RecipeScreen)
final mealProvider = FutureProvider<MealModel>((ref) {
  return MealRepository().getMeal();
});

// Provider to fetch meals by category (used by ExploreScreen)
final mealsByCategoryProvider =
    FutureProvider.family<List<MealModel>, String>((ref, category) async {
  final repository = MealRepository();
  if (category == "All") {
    // Use searchMealsByName with an empty query to fetch all meals
    return await repository.searchMealsByName('');
  } else {
    // Fetch meals filtered by the selected category
    return await repository.getMealsByCategory(category);
  }
});

// Provider to search meals by name (used in ExploreScreen for search functionality)
final searchMealsProvider =
    FutureProvider.family<List<MealModel>, String>((ref, query) {
  return MealRepository().searchMealsByName(query);
});
