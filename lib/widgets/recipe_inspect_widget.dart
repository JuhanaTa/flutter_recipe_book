import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';
import 'package:recipe_book/models/ingredient.dart';
import 'package:recipe_book/models/recipe.dart';

class RecipeInspectWidget extends StatelessWidget {
  final Recipe? recipe;
  final RecipeController recipeController = Get.find<RecipeController>();

  RecipeInspectWidget(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Text("Ingredients:"),
      ...recipe!.ingredients.asMap().entries.map((entry) {
        Ingredient ingredient = entry.value;
        return RecipeIngredientItem(ingredient);
      }),
      Text("How to cook:"),
      DescriptionItem(recipe),
    ]);
  }
}

class RecipeIngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  const RecipeIngredientItem(this.ingredient, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
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
      margin: const EdgeInsets.all(5),
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
