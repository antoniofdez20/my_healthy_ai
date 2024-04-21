import 'package:flutter/material.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class CustomInputDecoration {
  static InputDecoration buildInputDecoration({
    required String labelText,
    required ThemeController themeController,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: themeController.isDarkMode.value
            ? MyColors.midnightGreen
            : MyColors.prussianBlue,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: themeController.isDarkMode.value
              ? MyColors.midnightGreen
              : MyColors.prussianBlue,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: themeController.isDarkMode.value
              ? MyColors.midnightGreen
              : MyColors.prussianBlue,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      filled: true,
      fillColor: themeController.isDarkMode.value
          ? MyColors.midnightGreen
          : MyColors.uranianBlue,
      suffixIcon: suffixIcon,
    );
  }
}
