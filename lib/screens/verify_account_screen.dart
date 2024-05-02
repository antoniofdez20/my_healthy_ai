import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Verify your email and your account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await authController.verifyEmail();
                  },
                  child: const Text('Verify Account'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Muestra un diálogo de confirmación usando GetX
                    Get.defaultDialog(
                      title: "Confirm Delete Account",
                      content: const Text(
                          "Are you sure you want to delete your account? This action cannot be undone."),
                      onCancel:
                          () {}, // Al presionar cancelar, simplemente cierra el diálogo
                      onConfirm: () async {
                        Get.back(); // Cierra el diálogo después de la acción
                        // Al confirmar, procede a eliminar la cuenta
                        await authController.deleteAccount();
                      },
                      textCancel: "Cancel",
                      textConfirm: "Delete",
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.red,
                    );
                  },
                  child: const Text('Delete Account'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
