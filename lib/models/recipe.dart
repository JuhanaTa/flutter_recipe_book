import 'package:recipe_book/models/ingredient.dart';

class Recipe {
  final String name;
  final String description;
  final bool favorite;
  final List<Ingredient> ingredients;

  Recipe({required this.name, required this.description, required this.ingredients, required this.favorite});

  // From Recipe to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description, 
        'favorite': favorite,
        'ingredients': ingredients.map((ing) => ing.toJson()).toList(),
      };

  // From JSON to Recipe
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
      favorite: json['favorite'], 
      ingredients: parsedIngredients
    );
  }
}
