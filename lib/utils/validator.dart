import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class FormValidator {
  String? isValidName(String? text) {
    if (text == null || text.isEmpty || text.length < 3) {
      return "Este nombre NO es válido";
    }
    return null;
  }

  String? isValidEmail(String? text) {
    return (text ?? "").isEmail ? null : "Este email NO es válido";
  }

  String? isValidPass(String? text) {
    if (text == null || text.isEmpty) return 'La contrasenya és obligatoria';

    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    if (!regex.hasMatch(text)) {
      return 'La contrasenya ha de tenir almenys 6 caràcters, lletres i números';
    }

    return null;
  }

  String? isValidPassConfirmed(String? text, String? passConf) {
    if (passConf == null || passConf.isEmpty) {
      return "Por favor, confirma tu contraseña";
    }

    if (text != passConf) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  showSnackbarError(String message) {
    Get.snackbar(
      "Error",
      message,
      shouldIconPulse: false,
      duration: const Duration(seconds: 4),
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      backgroundColor: const Color.fromARGB(160, 233, 62, 50),
      colorText: MyColors.prussianBlue,
      messageText: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: MyColors.prussianBlue,
        ),
      ),
    );
  }

  showSnackbarSuccess(String message) {
    Get.snackbar(
      "Success",
      message,
      shouldIconPulse: false,
      duration: const Duration(seconds: 4),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      backgroundColor: const Color.fromARGB(160, 56, 203, 152),
      colorText: MyColors.prussianBlue,
      messageText: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: MyColors.prussianBlue,
        ),
      ),
    );
  }
}
