import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({super.key});
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo.png', width: 300, height: 300),
            const Text(
              'Welcome to My Healthy AI',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/loginScreen');
              },
              child: const Text('Login'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                //logica para iniciar sesion con google
              },
              icon: Image.asset(
                'assets/icons/google_icon.png',
                width: 20,
                height: 20,
              ), //const Icon(FontAwesomeIcons.google),
              label: const Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
