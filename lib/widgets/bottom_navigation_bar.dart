import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    String currentRoute = Get.currentRoute;
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFF38CB98)),
            onPressed: () {
              if (currentRoute != '/homeScreen') {
                Get.offNamed('/homeScreen');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              if (currentRoute != '/profileScreen') {
                Get.offNamed('/profileScreen');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              if (currentRoute != '/settingsScreen') {
                Get.offNamed('/settingsScreen');
              }
            },
          ),
        ],
      ),
    );
  }
}
