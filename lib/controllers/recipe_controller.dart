import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:recipe_book/models/recipe.dart';

class RecipeController {
  final storage = Hive.box("storage");

  RxList recipes;

  RecipeController() : recipes = [].obs {
    final storedRecipes = storage.get('recipes');
    print(storedRecipes);
    if (storedRecipes == null) {
      storage.put('recipes', []);
    } else {
      // Convert each map to a Recipe object
      final loadedRecipes = (storedRecipes as List)
          .map((json) => Recipe.fromJson(Map<String, dynamic>.from(json)))
          .toList();
      recipes.assignAll(loadedRecipes);
    }

    print('data');
    print(recipes);

  }

  void _save() {
    storage.put(
      'recipes',
      recipes.map((recipe) => recipe.toJson()).toList(),
    );
  }

  // Recipe? because on some cases the recipe index could be invalid.
  Recipe? getOneRecipe(int index) {
    // check that recipe with that specific index actually exist.
    if (index >= 0 && index < recipes.length) {
      return recipes[index];
    }
    // return null if no recipes exist.
    return null;
  }

  void add(Recipe recipe) {
    recipes.add(recipe);
    _save();
  }

  void delete(Recipe recipe) {
    recipes.remove(recipe);
    recipes.refresh();
    _save();
  }

  get size => recipes.length;
}
