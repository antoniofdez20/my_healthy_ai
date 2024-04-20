import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/preferences/preferences.dart';
import 'package:my_healthy_ai/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesTheme.init();
  Get.put(ThemeController());
  runApp(MyApp(initialRoute: '/initialScreen'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({super.key, required this.initialRoute});
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Healthy AI',
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/initialScreen', page: () => InitialScreen()),
        GetPage(name: '/loginScreen', page: () => const LoginScreen()),
        GetPage(
            name: '/createAccountScreen',
            page: () => const CreateAccountScreen()),
        GetPage(name: '/homeScreen', page: () => const HomeScreen()),
      ],
      theme: themeController.currentTheme,
    );
  }
}
