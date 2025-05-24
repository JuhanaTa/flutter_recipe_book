import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/widgets/recipe_add_widget.dart';

class NewRecipeScreen extends StatelessWidget {
  const NewRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final usedRoute = Get.currentRoute;
    String appBarText = "New Recipe";

    // New recipe screen used for editRecipe as well.
    // Assign appBar to edit recipe if route contains it.
    if(usedRoute.contains("/editRecipe")){
      appBarText = "Edit Recipe";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarText),
          leading: BackButton(
            onPressed: () => Get.back(),
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: RecipeAddWidget(),
          ),
        ));
  }
}
