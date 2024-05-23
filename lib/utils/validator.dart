import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class FormValidator {
  String? isValidName(String? text) {
    if (text == null || text.isEmpty || text.length < 3) {
      return "This name is not valid";
    }
    return null;
  }

  String? isValidEmail(String? text) {
    return (text ?? "").isEmail ? null : "This email is not valid";
  }

  String? isValidPass(String? text) {
    if (text == null || text.isEmpty) return 'The password is required';

    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!regex.hasMatch(text)) {
      return 'The password must contain at least 8 characters, including letters and numbers';
    }

    return null;
  }

  String? isValidPassConfirmed(String? text, String? passConf) {
    if (passConf == null || passConf.isEmpty) {
      return "Please confirm your password";
    }

    if (text != passConf) {
      return "Passwords do not match";
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
      isDismissible: true,
      dismissDirection: DismissDirection.up,
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
      isDismissible: true,
      dismissDirection: DismissDirection.up,
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
