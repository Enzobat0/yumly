class MealModel {
  final String id;
  final String name;
  final String category;
  final String instructions;
  final String image;
  final List<Ingredients> ingredients;

  
  MealModel({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.image,
    required this.ingredients,
  });

  // Factory method for full meal details
  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['meals'][0]['idMeal'],
      name: json['meals'][0]['strMeal'],
      category: json['meals'][0]['strCategory'] ?? 'Unknown',
      instructions: json['meals'][0]['strInstructions'] ?? '',
      image: json['meals'][0]['strMealThumb'] ?? '',
      ingredients: List.generate(
        20,
        (index) => Ingredients(
          json['meals'][0]['strIngredient${index + 1}'] ?? '',
          json['meals'][0]['strMeasure${index + 1}'] ?? '',
        ),
      ).where((ingredient) => ingredient.name.isNotEmpty).toList(),
    );
  }

  // Factory method for a simple meal (used in explore screen)
  factory MealModel.fromFilteredJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? 'Unknown Meal',
      category: json['strCategory'] ?? '', 
      instructions: '', 
      image: json['strMealThumb'] ?? '',
      ingredients: [], 
    );
  }

  
  bool isValid() {
    return id.isNotEmpty && name.isNotEmpty && image.isNotEmpty;
  }
}

class Ingredients {
  final String name;
  final String measure;

  Ingredients(this.name, this.measure);
}
