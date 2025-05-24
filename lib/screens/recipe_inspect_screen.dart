import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';
import 'package:recipe_book/models/recipe.dart';
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
  final Recipe? recipe;

  RecipeInspectScreen({super.key})
      : recipe = _getRecipeFromParameters(
            Get.parameters, Get.find<RecipeController>());

  static Recipe? _getRecipeFromParameters(
      Map<String, String?> parameters, RecipeController controller) {
    String? indexString = parameters['recipe'];

    if (indexString != null) {
      try {
        // Parse the parameter string as an integer index
        int recipeIndex = int.parse(indexString);

        // Use the controller's function to get the recipe by index
        return controller.getOneRecipe(recipeIndex);
      } catch (e) {
        // Handle parsing errors
        print("Error parsing recipeId '$indexString': $e");
        return null;
      }
    } else {
      // Handle case where recipeId parameter is missing
      print("Error: recipeId parameter missing from route");
      return null;
    }
  }

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
