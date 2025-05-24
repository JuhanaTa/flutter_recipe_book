import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/widgets/recipe_inspect_widget.dart';

List<Widget> mainComponents() {
  final recipeParam = Get.parameters['recipe'];

  // Return null if no recipes in parameters
  if (recipeParam != null) {
    final recipeIndex = int.parse(recipeParam);

    final List<Widget> list = [
      // Show search box
      Expanded(
        child: RecipeInspectWidget(recipeIndex),
      ),
    ];

    return list;
  } else {
    final List<Widget> list = [
      // Show search box
      Expanded(
        child: const Text("No recipe found"),
      ),
    ];
    return list;
  }
}

class RecipeInspectScreen extends StatelessWidget {

  const RecipeInspectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Screen"),
        leading: BackButton(
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: mainComponents(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Based on route parameters figure out which recipe page to navigate to.
          String? recIndex = Get.parameters['recipe'];
          Get.toNamed("/editRecipe/$recIndex");
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
