import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  await dotenv.load(fileName: ".env");
  Get.put(ThemeController());
  Get.put(AuthController());
  //Get.put(RecetasController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.find<ThemeController>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Healthy AI',
      initialRoute: authController.firebaseUser.value?.uid != null
          ? authController.firebaseUser.value?.emailVerified == true
              ? '/homeScreen'
              : '/verifyAccountScreen'
          : '/initialScreen',
      getPages: AppPages.routes,
      theme: themeController.currentTheme,
    );
  }
}
