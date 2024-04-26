import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_healthy_ai/auth/auth_firebase_repository.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rxn<User?> firebaseUser = Rxn<User?>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //funcion para conocer si el usuario esta logueado o no
  Stream<User?> get userStream => _auth.authStateChanges();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(userStream); // Escucha los cambios de autenticación
    /* firebaseUser.listen((user) {
      print("Usuario actualizado: ${user?.displayName}");
      print("Usuario actualizado: ${user?.email}");
    }); */
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  registerWithEmailAndPassword() async {
    try {
      firebaseUser.value =
          await AuthFirebaseRepository().registerWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      Get.snackbar("Congrats", "You are registered!", shouldIconPulse: false);
    } catch (e) {
      Get.snackbar("Error", e.toString(), shouldIconPulse: false);
    }
  }

  loginWithEmailAndPassword() async {
    try {
      firebaseUser.value =
          await AuthFirebaseRepository().loginWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), shouldIconPulse: false);
    }

    Get.snackbar("Congrats", "You are logged in!", shouldIconPulse: false);
  }

  loginWithGoogle() async {
    try {
      firebaseUser.value = await AuthFirebaseRepository().sigInWithGoogle();

      Get.snackbar("Congrats", "You are logged in!", shouldIconPulse: false);
    } catch (e) {
      Get.snackbar("Error", e.toString(), shouldIconPulse: false);
    }
  }

  Future<void> signOut() async {
    var isGoogleUser = firebaseUser.value?.providerData
            .any((userInfo) => userInfo.providerId == 'google.com') ??
        false;

    if (isGoogleUser) {
      // Desconecta la sesión de Google
      await _googleSignIn.signOut();
    }

    // Siempre cierra la sesión de Firebase
    await _auth.signOut();
  }

  resetCredentials() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
