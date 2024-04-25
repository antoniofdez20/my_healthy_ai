import 'package:get/get.dart';
import 'package:my_healthy_ai/screens/screens.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/initialScreen', page: () => InitialScreen()),
    GetPage(name: '/loginScreen', page: () => const LoginScreen()),
    GetPage(
      name: '/createAccountScreen',
      page: () => const CreateAccountScreen()),
    GetPage(name: '/homeScreen', page: () => const HomeScreen()),
  ];
}