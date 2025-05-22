import 'package:recipe_book/models/ingredient.dart';

class Recipe {
  final String name;
  final String description;
  final List<Ingredient> ingredients;

  Recipe({required this.name, required this.description, required this.ingredients});

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description, 
        'ingredients': ingredients.map((ing) => ing.toJson()).toList(),
      };

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var ingredientsJSON = json['ingredients'] as List<dynamic>?;

    List<Ingredient> parsedIngredients = ingredientsJSON != null
        ? ingredientsJSON
            .map((item) => Ingredient.fromJson(Map<String, dynamic>.from(item)))
            .toList()
        : [];

    return Recipe(
      name: json['name'], 
      description: json['description'], 
      ingredients: parsedIngredients
    );
  }
}
