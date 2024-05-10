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
      body: Center(
        child: Text(tempReceta?.title ?? 'No Recipe'),
      ),
    );
  }
}
