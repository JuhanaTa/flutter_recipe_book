import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';
import 'package:recipe_book/models/ingredient.dart';
import 'package:recipe_book/models/recipe.dart';

class RecipeInspectWidget extends StatelessWidget {
  final int recipeIndex;

  RecipeInspectWidget(this.recipeIndex, {super.key});

  final RecipeController recipeController = Get.find();

  _setFavourite(recipe, bool favoriteStatus) {
    final recipeParam = Get.parameters['recipe'];
    if (recipeParam != null) {
      final updatedRecipe = Recipe(
        name: recipe.name,
        description: recipe.description,
        favorite: favoriteStatus,
        ingredients: recipe.ingredients,
      );

      // Get index of recipe
      final recipeIndex = int.parse(recipeParam);
      // Save the favorite status
      recipeController.edit(updatedRecipe, recipeIndex);
    }
  }

  _deleteRecipe(recipe) {
    // Save the favorite status
    recipeController.delete(recipe);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final recipe = recipeController.getOneRecipe(recipeIndex);

      // Fallback if user navigates to bad route.
      if (recipe == null) {
        return const Text("Recipe not found");
      }

      return Padding(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(recipe.name, style: TextStyle(fontSize: 20)),
                  ElevatedButton.icon(
                    onPressed: () => _deleteRecipe(recipe),
                    label: Text("Delete"),
                    icon: const Icon(Icons.delete),
                  ),
                ]),
            const SizedBox(height: 16),
            Text("Set as favorite:"),
            const SizedBox(height: 4),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: recipe.favorite
                    ? [
                        const Text(
                          "Currently one of your favorites.",
                          style: TextStyle(color: Colors.green),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _setFavourite(recipe, false),
                          label: Text("Dislike"),
                          icon: const Icon(Icons.heart_broken),
                        ),
                      ]
                    : [
                        const Text(
                          "Currently not one of your favorites.",
                          style: TextStyle(color: Colors.red),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _setFavourite(recipe, true),
                          label: Text("Like"),
                          icon: const Icon(Icons.favorite_outline),
                        ),
                      ]),
            const SizedBox(height: 8),
            Text("How to cook:"),
            const SizedBox(height: 8),
            DescriptionItem(recipe),
            const SizedBox(height: 8),
            Text("Ingredients:"),
            const SizedBox(height: 8),
            ...(recipe.ingredients.isNotEmpty
                ? recipe.ingredients.asMap().entries.map((entry) {
                    Ingredient ingredient = entry.value;
                    return RecipeIngredientItem(ingredient);
                  })
                : [const Text("No ingredients saved for this recipe.")]),
          ]));
    });
  }
}

class RecipeIngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  const RecipeIngredientItem(this.ingredient, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.red.withAlpha(90),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(ingredient.item ?? ""),
          Text("${ingredient.amount ?? ""}${ingredient.unit ?? ""}"),
        ],
      ),
    );
  }
}

class DescriptionItem extends StatelessWidget {
  final Recipe? recipe;
  const DescriptionItem(this.recipe, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.green.withAlpha(90),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(recipe!.description),
        ],
      ),
    );
  }
}
