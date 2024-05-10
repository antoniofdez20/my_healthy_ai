import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recetasController = Get.find<RecetasController>();
    final tempReceta = recetasController.tempReceta.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(tempReceta?.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tempReceta?.title ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(tempReceta?.description ?? ''),
                    const SizedBox(height: 20),
                    const Text(
                      'INGREDIENTES',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        'Calabaza ......... 1Kg \nCebolla morada ......... 1 unidad\nAceite de oliva ......... 2 cucharadas\nSal ......... al gusto\nPimienta ......... al gusto'),
                    const SizedBox(height: 20),
                    const Text(
                      'PREPARACIÓN',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        '1. Precalentar el horno a 180ºC.\n2. Cortar la calabaza en trozos y la cebolla en juliana.\n3. En una bandeja de horno, colocar la calabaza y la cebolla, añadir el aceite de oliva, la sal y la pimienta.\n4. Hornear durante 30 minutos.\n5. Servir caliente.'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      recetasController.toggleFavourite(
                        recetasController.recetas.indexWhere(
                          (element) => element['title'] == tempReceta?.title,
                        ),
                      );
                    },
                    label: const Text('Toggle Favourite'),
                    icon: const Icon(Icons.favorite_border_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
