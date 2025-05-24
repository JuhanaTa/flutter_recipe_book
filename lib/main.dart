import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';
import 'package:recipe_book/controllers/recipe_form_controller.dart';
import 'package:recipe_book/screens/home_screen.dart';
import 'package:recipe_book/screens/new_recipe_screen.dart';
import 'dart:ui';

import 'package:recipe_book/screens/recipe_inspect_screen.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");

  // had issues with controllers while using lazyPut
  // Get.put could be used here but lazyPut has also fenix parameter which allows the controller be 
  // recreated automatically when needed multiple times, e.g. when navigating multiple times from page to page.
  // https://stackoverflow.com/questions/71734768/diff-between-get-put-and-get-lazyput
  Get.lazyPut<RecipeController>(() => RecipeController(), fenix: true);
  Get.lazyPut<RecipeFormController>(() => RecipeFormController(), fenix: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: CustomScrollBehavior(),

      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => HomeScreen()),
        GetPage(name: "/newRecipe", page: () => NewRecipeScreen()),
        // Re-use the NewRecipeScreen and pass recipe nam
        GetPage(name: "/editRecipe/:recipe", page: () => NewRecipeScreen()),
        GetPage(name: "/recipe/:recipe", page: () => RecipeInspectScreen())
      ],
    );
  }
}




