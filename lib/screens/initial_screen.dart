import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/widgets/widgets.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({super.key});
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Healthy AI'),
      ),
      body: const Center(
        child: Text('Initial Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          themeController.toggleTheme();
        },
        child: const Icon(Icons.arrow_forward),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
