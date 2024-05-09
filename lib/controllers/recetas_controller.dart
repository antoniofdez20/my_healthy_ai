import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecetasController extends GetxController {
  final RxList<Map<String, dynamic>> recetas = <Map<String, dynamic>>[].obs;
  TextEditingController searchController = TextEditingController();
  final List<String> filtros = [
    'Carne',
    'Pescado',
    'Vegetariano',
    'Comida',
    'Cena',
    'Postre',
    'Desayuno',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchRecetas();
  }

  void toggleFavourite(int index) {
    var current = recetas[index];
    current['isFavourite'] = !(current['isFavourite'] as bool? ?? false);
    recetas[index] = Map.from(
        current); // Esta línea es crucial para que GetX detecte el cambio
  }

  void fetchRecetas() {
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
  }
}
