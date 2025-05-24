import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipe_book/controllers/recipe_controller.dart';
import 'package:recipe_book/controllers/recipe_form_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_book/models/ingredient.dart';
import 'package:recipe_book/models/recipe.dart';

class RecipeAddWidget extends StatelessWidget {
  RecipeAddWidget({super.key, this.recipe});

  final Recipe? recipe;
  bool recipeEdit = false;

  Recipe? _getRecipeForEdit(RecipeController recipe) {
    final recipeParam = Get.parameters['recipe'];
    
    // Return null if no recipes in parameters
    if(recipeParam == null) {
      return null;
    }

    final recipeIndex = int.parse(recipeParam);
    final RecipeController controller = Get.find();

    return controller.getOneRecipe(recipeIndex);
  }

  static final _formKey = GlobalKey<FormBuilderState>();

  // New recipe can be submitted or based on the editFlag existing recipe can be edited.
  // On both cases the recipe is formed, but edit just replaces the recipe from specific index.
  _submit(RecipeController controller, RecipeFormController recipeFormController, bool editFlag) {
    print('submit');
    if (_formKey.currentState!.saveAndValidate()) {

      // Ingredient fields however uses recipeFormController
      final fields = recipeFormController.fields;

      final List<Ingredient> ingredients = [];

      for (var i = 0; i < fields.length; i++) {
        final item = fields[i].itemController.text;
        final unit = fields[i].defUnit.value;
        final type = fields[i].ingredientType;
        final amount = fields[i].amountController.text;

        print(item);
        print(unit);
        print(type);
        print(amount);

        ingredients.add(Ingredient(
          item: item,
          unit: unit,
          type: type,
          amount: amount,
        ));
      }

      // Compine ingredients and recipe name to Recipe class instance
      Recipe recipe = Recipe(
        name: _formKey.currentState!.value['RecipeName'],
        description: _formKey.currentState!.value['RecipeDescription'],
        ingredients: ingredients,
      );


      if(editFlag){
        final recipeParam = Get.parameters['recipe'];
        if(recipeParam != null) {
          // Get index of editable recipe
          final recipeIndex = int.parse(recipeParam);
          // Save the new edited recipe
          controller.edit(recipe, recipeIndex);
        }
      } else {
        controller.add(recipe);
      } 


      _formKey.currentState?.reset();
      recipeFormController.clear();

      // when recipe created, navigate back
      Get.offAllNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.find();
    final RecipeFormController recipeFormController = Get.find();

    // Fetch the recipe if user is editing the recipe
    final Recipe? recipe = _getRecipeForEdit(controller);

    // Set recipe edit flag to figure out how to save the recipe
    // used on _submit method to either save new recipe or edit existing one.
    if(recipe != null){
      recipeEdit = true;
    }

    if(recipe != null){
      recipeFormController.setEditableIngredientFields(recipe.ingredients);
    }

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              children: [

                FormBuilderTextField(
                  name: 'RecipeName',
                  decoration: InputDecoration(
                    hintText: 'Insert your recipe name here',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  validator: FormBuilderValidators.required(),

                  // If editing, the initial name is populated
                  initialValue: recipe?.name ?? "",
                ),

                SizedBox(height: 16),

                FormBuilderTextField(
                  name: 'RecipeDescription',
                  decoration: InputDecoration(
                    hintText: 'How to cook your recipe...',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  validator: FormBuilderValidators.required(),
                  // Do not limit how many rows there are for the description.
                  maxLines: null,
                  // If editing, the initial description is populated
                  initialValue: recipe?.description ?? "",
                ),

                SizedBox(height: 16),

                Row(children: [

                  ElevatedButton(
                    onPressed: () => recipeFormController.addField("Liquid"),
                    child: Text("Add liquid"),
                  ),

                  SizedBox(width: 16),

                  ElevatedButton(
                    onPressed: () => recipeFormController.addField("Ingredient"),
                    child: Text("Add ingredient"),
                  ),
                ]),

                SizedBox(height: 16),

                Obx(
                  () => Column(
                    children: List.generate(recipeFormController.fields.length, (i) {
                      final field = recipeFormController.fields[i];
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                flex: 4,
                                child: FormBuilderTextField(
                                  name: 'ingredient$i',
                                  controller: field.itemController,
                                  decoration: InputDecoration(
                                    labelText: field.ingredientType,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),

                              SizedBox(width: 16),

                              Expanded(
                                flex: 1,
                                child: FormBuilderTextField(
                                  name: 'amount$i',
                                  controller: field.amountController,

                                  // Allow only numbers and decimals to be written on amount box
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),

                                  // With regex allow only numbers with decimals
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],

                                  decoration: InputDecoration(
                                    labelText: 'Amount',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),

                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField<String>(
                                  value: field.defUnit.value,
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: FormBuilderValidators.required(),
                                  decoration: InputDecoration(
                                    labelText: 'Unit',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    if (value != null) {
                                      field.defUnit.value = value;
                                    }
                                  },
                                  items: field.units
                                      .map((unit) => DropdownMenuItem(
                                            value: unit,
                                            child: Text(unit),
                                          ))
                                      .toList(),
                                ),
                              ),
                              
                              IconButton(
                                icon: const Icon(Icons.clear),
                                tooltip: 'Delete',
                                onPressed: () => recipeFormController.removeField(i),
                              ),

                            ],
                          ),
                          const Divider(thickness: 1),
                        ],
                      );
                    }),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => _submit(controller, recipeFormController, recipeEdit),
                  child: Text("Save"),
                ),
              ],
            ),
          )),
    );
  }
}
