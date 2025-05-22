import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/widgets/recipe_add_widget.dart';
import 'package:recipe_book/widgets/recipe_inspect_widget.dart';

List<Widget> mainComponents(Recipe? recipe) {
  final List<Widget> list = [
    // Show search box
    Expanded(
      child: RecipeInspectWidget(recipe),
    ),

    // Show listing of categories
    /*Expanded(
      child: RecipeListWidget(),
    )*/
  ];

  return list;
}

class RecipeInspectScreen extends StatelessWidget {
  final Recipe? recipe;

  RecipeInspectScreen({Key? key}) : recipe = _getRecipeFromParameters(Get.parameters, Get.find<RecipeController>()), super(key: key);

  static Recipe? _getRecipeFromParameters(Map<String, String?> parameters, RecipeController controller) {
    String? indexString = parameters['recipe'];

    print("parameters");
    print(parameters);

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
        title: Text(recipe != null ? recipe!.name : ""),
        leading: BackButton(
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Column(
            children: mainComponents(recipe),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print("Should navigate to edit recipe");
          //print(recipe!.ingredients);

          // Navigate to edit recipe screen by taking the index parameter of recip
          //Get.toNamed("/editRecipe/");

          String? recIndex = Get.parameters['recipe']; 
          Get.toNamed("/editRecipe/$recIndex");
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
