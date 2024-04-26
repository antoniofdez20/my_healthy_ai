import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final firebaseUser = authController.firebaseUser.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await authController.signOut();
              Get.offAllNamed('/initialScreen');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              firebaseUser?.displayName?.isNotEmpty == true
                  ? firebaseUser!.displayName!
                  : 'No name',
              style: const TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
