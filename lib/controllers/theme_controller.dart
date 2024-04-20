import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/preferences/preferences.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class ThemeController extends GetxController {
  ThemeData get currentTheme =>
      isDarkMode.value ? MyTheme.darkTheme : MyTheme.lightTheme;
  RxBool isDarkMode = PreferencesTheme.isDarkMode.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    PreferencesTheme.isDarkMode = isDarkMode.value;
    Get.changeTheme(currentTheme);
  }

  void resetTheme() {
    isDarkMode.value = false;
    PreferencesTheme.isDarkMode = false;
    Get.changeTheme(MyTheme.lightTheme);
  }
}
