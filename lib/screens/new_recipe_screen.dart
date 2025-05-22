import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/widgets/recipe_add_widget.dart';

class NewRecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Recipe"),
          leading: BackButton(
            onPressed: () => Get.back(),
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000),
            child: RecipeAddWidget(),
          ),
        ));
  }
}
