import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';

class RecipeSearchWidget extends StatelessWidget {
  final controller = Get.find<RecipeController>();
  static final searchKey = GlobalKey<FormBuilderState>();

  // TODO: Implement recipe filter here.
  _search() {
    if (searchKey.currentState!.saveAndValidate()) {
      final searchWord = searchKey.currentState!.value['RecipeFilter'] as String?;
      if (searchWord != null) {
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
          Padding(padding: EdgeInsets.all(8)),
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
          ])
        ],
      ),
    );
  }
}
