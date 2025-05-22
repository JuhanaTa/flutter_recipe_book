import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/widgets/app_bar.dart';
import 'package:recipe_book/widgets/recipe_search_widget.dart';
import 'package:recipe_book/widgets/recipe_list_widget.dart';

List<Widget> mainComponents() {
  final List<Widget> list = [
    // Show search box
    RecipeSearchWidget(),

    // Show listing of categories
    Expanded(
      child: RecipeListWidget(),
    )
  ];

  return list;
}

class Breakpoints {
  static const sm = 640;
  static const md = 768;
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Column(
            children: mainComponents(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/newRecipe");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
