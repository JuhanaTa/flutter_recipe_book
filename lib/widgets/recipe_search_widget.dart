import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';

class RecipeSearchWidget extends StatelessWidget {
  final controller = Get.find<RecipeController>();
  static final searchKey = GlobalKey<FormBuilderState>();

  _search() {
    if (searchKey.currentState!.saveAndValidate()) {
      final searchWord = searchKey.currentState!.value['RecipeFilter'] as String?;

      // Do nothing if searchWord is null
      if (searchWord != null) {
        // Send searchWord to recipeController which filters the visible recipes
        controller.filterRecipes(searchKey.currentState!.value['RecipeFilter']);
      }
    }
  }

  _clearSearch() {
    searchKey.currentState?.reset();
    controller.clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          FormBuilder(
            key: searchKey,
            child: FormBuilderTextField(
              name: 'RecipeFilter',
              decoration: InputDecoration(
                hintText: 'Search for Recipe',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton.icon(
              onPressed: _search,
              label: Text("Search"),
              icon: const Icon(Icons.search),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: _clearSearch,
              label: Text("Clear"),
              icon: const Icon(Icons.clear),
            ),
          ]),
          const SizedBox(height: 16),
          Obx(()=>
            Text("Showing ${controller.filteredRecipes.length} / ${controller.recipes.length} Recipes")
          )
        ],
      ),
    );
  }
}
