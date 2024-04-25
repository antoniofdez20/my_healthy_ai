import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/firebase_options.dart';
import 'package:my_healthy_ai/preferences/preferences.dart';
import 'package:my_healthy_ai/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesTheme.init();
  Get.put(ThemeController());
  Get.put(AuthController());
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
      getPages: AppPages.routes,
      theme: themeController.currentTheme,
    );
  }
}                                                                                                                           
