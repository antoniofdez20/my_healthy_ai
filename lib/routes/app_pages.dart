import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/screens/screens.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/initialScreen',
      page: () => InitialScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: '/loginScreen',
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: '/createAccountScreen',
      page: () => const CreateAccountScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: '/homeScreen',
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
        Get.lazyPut<RecetasController>(() => RecetasController());
      }),
    ),
    GetPage(
      name: '/profileScreen',
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
        Get.lazyPut<RecetasController>(() => RecetasController());
      }),
    ),
    GetPage(
      name: '/verifyAccountScreen',
      page: () => const VerifyAccountScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: '/chatScreen',
      page: () => const ChatScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: '/detailsScreen',
      page: () => const DetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
  ];
}
