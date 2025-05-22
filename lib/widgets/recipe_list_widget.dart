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
      () => GridView.count(
        crossAxisCount: count,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: recipeController.recipes.asMap().entries.map((entry) {
          // we need the index of recipe to navigate to proper inspect page
          int index = entry.key;
          Recipe recipe = entry.value;

          return InkWell(
            onTap: () {
              print('Tapped on recipe: ${recipe.name}');
              Get.toNamed("/recipe/$index");
            },
            splashColor: Colors.black.withAlpha(30),
            child: RecipeText(recipe.name),
          );
        }).toList(),
      ),
    );
  }
}

class RecipeText extends StatelessWidget {
  final String text;
  const RecipeText(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red.withAlpha(90),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(text),
      ),
    );
  }
}
