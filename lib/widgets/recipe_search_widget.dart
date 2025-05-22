import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';

class RecipeSearchWidget extends StatelessWidget {
  final taskController = Get.find<RecipeController>();

  // TODO: Implement recipe filter here.
  _search() {
    print('This should search');
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              
              FormBuilderTextField(
                name: 'Recipe',
                decoration: InputDecoration(
                  hintText: 'Search for Recipe',
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
              ElevatedButton(
                onPressed: _search,
                child: Text("Search"),
              ),
            ],
          ),
        ));
  }
}
