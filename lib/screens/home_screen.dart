import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final recetasController = Get.find<RecetasController>();
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: recetasController.recetas.length,
          itemBuilder: (context, index) {
            final receta = recetasController.recetas[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.asset(receta['image']),
                title: Text(receta['title']),
                subtitle: Text(receta['description']),
                trailing: IconButton(
                  icon: receta['isFavourite']
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border),
                  onPressed: () => recetasController.toggleFavourite(index),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        user: authController.firebaseUser.value,
      ),
    );
  }
}
