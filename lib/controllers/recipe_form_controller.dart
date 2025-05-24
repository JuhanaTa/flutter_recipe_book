import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/models/ingredient.dart';

class IngredientField {
  final TextEditingController itemController;
  final TextEditingController amountController;
  RxString defUnit;
  final List<String> units;
  final String ingredientType;
  String amount;

  IngredientField(String type): 
    itemController = TextEditingController(),
    amountController = TextEditingController(),
    // Default depending if liquid or solid ingredient
    defUnit = type == "Liquid" ? 'dl'.obs : 'g'.obs,
    // Units vary depending if liquid or solid ingredient
    units = type == "Liquid" ? ['ml', 'dl', 'l'] : ['g', 'kg', 'pc(s)'],
    ingredientType = type,
    amount = "0";
}

class RecipeFormController extends GetxController {
  var fields = <IngredientField>[].obs;

  void addField(String type) {
    fields.add(IngredientField(type));
  }

  void removeField(int index) {
    fields.removeAt(index);
  }

  void clear() {
    fields.clear();
  }

  void setEditableIngredientFields(List<Ingredient> ingredients){

    // Making sure that fields are empty, e.g. covers the case where recipes are inspected one after another.
    fields.clear();

    for (final singeIngredient in ingredients){
      //This creates the ingredient field
      addField(singeIngredient.type ?? "Liquid"); //Liquid might not be right if null but falling back to it instead of empty.
      
      //The new field is accesed here to assign other Ingredient field parameters
      final field = fields.last;

      // Currently saved and used unit must be set
      field.defUnit.value = singeIngredient.unit ?? "";

      // ingredient item name
      field.itemController.text = singeIngredient.item ?? '';

      // Set the right amount as well
      field.amountController.text = singeIngredient.amount?.toString() ?? '';
    }

  }

}