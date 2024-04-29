import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_healthy_ai/auth/auth_firebase_repository.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isPassObscured = true.obs;
  RxBool isConfirmPassObscured = true.obs;
  Rxn<User?> firebaseUser = Rxn<User?>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _validator = FormValidator();

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

  //cerrando los controladores al cerrar el authcontroller evitamos fugas de memoria
  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  registerWithEmailAndPassword() async {
    isLoading.value = true;
    try {
      firebaseUser.value =
          await AuthFirebaseRepository().registerWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
        userName: usernameController.value.text,
      );
      if (firebaseUser.value != null) {
        Get.offAllNamed('/homeScreen');
        _validator.showSnackbarSuccess("You are registered!");
      }
    } catch (e) {
      _validator.showSnackbarError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  loginWithEmailAndPassword() async {
    isLoading.value = true;
    try {
      firebaseUser.value =
          await AuthFirebaseRepository().loginWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      if (firebaseUser.value != null) {
        Get.offAllNamed('/homeScreen');
        _validator.showSnackbarSuccess("You are logged in!");
      }
    } catch (e) {
      // Captura de cualquier otro tipo de error
      _validator.showSnackbarError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  loginWithGoogle() async {
    try {
      firebaseUser.value = await AuthFirebaseRepository().sigInWithGoogle();

      if (firebaseUser.value != null) {
        Get.offAllNamed('/homeScreen');
        _validator.showSnackbarSuccess("You are logged in!");
      }
    } catch (e) {
      _validator.showSnackbarError(e.toString());
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

  void togglePasswordVisibility() {
    isPassObscured.value = !isPassObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPassObscured.value = !isConfirmPassObscured.value;
  }
}
