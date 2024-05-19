import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/models/models.dart';

class RecetasController extends GetxController {
  final ApiRecipeController _apiRecipeController = ApiRecipeController();
  final RxList<RecetaApi> recipes = <RecetaApi>[].obs;
  final RxList<RecetaApi> favouriteRecipes = <RecetaApi>[].obs;

  final RxList<Map<String, dynamic>> recetas = <Map<String, dynamic>>[].obs;
  final Rxn<RecetaApi> tempReceta = Rxn<RecetaApi>();
  TextEditingController searchController = TextEditingController();
  final List<String> filtros = [
    'Breakfast',
    'Dinner',
    'Lunch',
    'Snack',
    'American',
    'Asian',
    'Chinese',
    'Mexican',
    'Mediterranean'
  ];

  @override
  void onInit() {
    super.onInit();
    //fetchRecetas();
    getRecetasApi();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleFavourite(int index) {
    var current = recetas[index];
    current['isFavourite'] = !(current['isFavourite'] as bool? ?? false);
    recetas[index] = Map.from(
        current); // Esta línea es crucial para que GetX detecte el cambio
  }

  /* void fetchRecetas() {
    List<Map<String, dynamic>> initialRecetas = List.generate(
      10,
      (index) => {
        'title': 'Receta ${index + 1}',
        'description': 'Descripción de la receta ${index + 1}',
        'image': 'assets/img/receta_placeholder.png',
        'isFavourite': false,
      },
    );
    recetas.assignAll(initialRecetas);
  } */

  void getRecetasApi() async {
    recipes.clear();
    recipes.value = await _apiRecipeController.getRecipes();
  }

  void getRecetasMealType(String mealType) async {
    recipes.clear();
    recipes.value = await _apiRecipeController.getRecipesMealType(mealType);
  }

  void getRecetasCuisineType(String cuisineType) async {
    recipes.clear();
    recipes.value =
        await _apiRecipeController.getRecipesCuisineType(cuisineType);
  }

  void getRecetasQuery(String query) async {
    recipes.clear();
    recipes.value = await _apiRecipeController.getRecipesQuery(query);
    searchController.clear();
  }
}
