import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recetasController = Get.find<RecetasController>();
    final authController = Get.find<AuthController>();
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
              SizedBox(
                width: double.maxFinite,
                height: 250,
                child: tempReceta?.image != null
                    ? CachedNetworkImage(
                        imageUrl: tempReceta!.image!,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/receta_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/img/receta_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      )
                    : Image.asset('assets/img/receta_placeholder.png',
                        fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tempReceta?.label ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Calories: ${tempReceta?.calories.toStringAsFixed(2)}'),
                    const SizedBox(height: 20),
                    const Text(
                      'INGREDIENTS',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    tempReceta?.ingredientLines != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tempReceta!.ingredientLines
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('* ${e.capitalizeFirst}.'),
                                        const SizedBox(height: 5),
                                      ],
                                    ))
                                .toList(),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    const Text(
                      'CUISINE TYPE',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    tempReceta?.cuisineType != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tempReceta!.cuisineType
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('* ${e.capitalizeFirst}.'),
                                        const SizedBox(height: 5),
                                      ],
                                    ))
                                .toList(),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    const Text(
                      'MEAL TYPE',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    tempReceta?.mealType != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tempReceta!.mealType
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('* ${e.capitalizeFirst}.'),
                                        const SizedBox(height: 5),
                                      ],
                                    ))
                                .toList(),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    const Text(
                      'DISH TYPE',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    tempReceta?.dishType != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tempReceta!.dishType
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('* ${e.capitalizeFirst}.'),
                                        const SizedBox(height: 5),
                                      ],
                                    ))
                                .toList(),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    const Text(
                      'PREPARATION',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        '1. Lorem ipsum dolor sit amet.\n2. Consectetur adipiscing elit.\n3. Suspendisse laoreet leo a nisi dictum semper.\n4. Mauris non nulla pellentesque, mattis.'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (recetasController
                          .isRecipeFavourite(tempReceta!.label)) {
                        final result = await authController
                            .deleteFavouriteRecipe(tempReceta);
                        if (result) {
                          recetasController.favouriteRecipes.removeWhere(
                              (element) => element.label == tempReceta.label);
                        }
                      } else {
                        recetasController.favouriteRecipes.add(tempReceta);
                        authController.updateFavouriteRecipe(tempReceta);
                      }
                    },
                    label: const Text('Toggle Favourite'),
                    icon: Obx(
                      () => IconButton(
                        icon: recetasController
                                .isRecipeFavourite(tempReceta!.label)
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                        onPressed: () async {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
