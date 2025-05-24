import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/screens/home_screen.dart';

class RecipeListWidget extends StatelessWidget {
  final RecipeController recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    int count = 4;
    if (size.width < Breakpoints.sm) {
      count = 2;
    } else if (size.width < Breakpoints.md) {
      count = 3;
    }

    count = count < 1 ? 1 : count;

    return Obx(
      () => recipeController.filteredRecipes.isNotEmpty
          ? GridView.count(
              crossAxisCount: count,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children:
                  recipeController.filteredRecipes.asMap().entries.map((entry) {
                // we need the index of recipe to navigate to proper inspect page
                int index = entry.key;
                Recipe recipe = entry.value;

                return InkWell(
                  onTap: () {
                    Get.toNamed("/recipe/$index");
                  },
                  splashColor: Colors.black.withAlpha(30),
                  child: RecipeText(recipe.name, recipe.favorite),
                );
              }).toList())
          : const Text(
              "No recipes exists yet or no matching recipes with the given searchword."),
    );
  }
}

class RecipeText extends StatelessWidget {
  final String text;
  final bool favorite;
  const RecipeText(this.text, this.favorite, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.withAlpha(90),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(size: 64, Icons.restaurant),
          Row(
            children: [],
          ),
          Text(text),
          if (favorite) Icon(size: 32, Icons.star, color: Colors.yellow),
        ],
      )),
    );
  }
}
