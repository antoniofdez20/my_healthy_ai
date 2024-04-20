import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/screens/screens.dart';

void main() => runApp(const MyApp(initialRoute: '/initialScreen'));

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Healthy AI',
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/initialScreen', page: () => const InitialScreen()),
        GetPage(name: '/loginScreen', page: () => const LoginScreen()),
        GetPage(
            name: '/createAccountScreen',
            page: () => const CreateAccountScreen()),
        GetPage(name: '/homeScreen', page: () => const HomeScreen()),
      ],
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7BAFD4),
          centerTitle: true,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color(0xFFD8E8E7),
        ),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      /* ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF01344A),
            centerTitle: true,
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Color(0xFF01344A),
          ),
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF09586A),
        ) */
    );
  }
}
