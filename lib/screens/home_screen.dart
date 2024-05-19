import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/utils/utils.dart';
import 'package:my_healthy_ai/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final recetasController = Get.find<RecetasController>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 280,
                    height: 55,
                    child: CustomTextField(
                        hintTextCustom: 'Search for recipes',
                        controller: recetasController.searchController),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(right: 1),
                      backgroundColor: MyColors.carolinaBlue,
                      fixedSize: const Size(55, 55),
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      if (recetasController.searchController.text.isNotEmpty) {
                        recetasController.getRecetasQuery(
                            recetasController.searchController.text);
                      }
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recetasController.filtros.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 55),
                          backgroundColor: MyColors.carolinaBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          if (index < 4) {
                            recetasController.getRecetasMealType(
                                recetasController.filtros[index]);
                          } else if (index ==
                              recetasController.filtros.length - 1) {
                            recetasController.getRecetasApi();
                          } else {
                            recetasController.getRecetasCuisineType(
                                recetasController.filtros[index]);
                          }
                        },
                        child: Text(recetasController.filtros[index]),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () {
                    if (recetasController.recipes.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: recetasController.recipes.length,
                        itemBuilder: (context, index) {
                          final receta = recetasController.recipes[index];
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              onTap: () {
                                recetasController.tempReceta.value = receta;
                                Get.toNamed('/detailsScreen');
                              },
                              leading: receta.image != null
                                  ? Image.network(receta.image!)
                                  : Image.asset(
                                      'assets/img/receta_placeholder.png'),
                              title: Text(receta.label),
                              subtitle: Text(
                                  'Calories: ${receta.calories.toStringAsFixed(2)}'),
                              /* trailing: IconButton(
                  icon: receta['isFavourite']
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border),
                  onPressed: () =>
                      recetasController.toggleFavourite(index),
                ), */
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        user: authController.firebaseUser.value,
      ),
    );
  }
}
