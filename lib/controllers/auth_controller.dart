import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/auth/auth_firebase_repository.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rxn<User?> firebaseUser = Rxn<User?>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  registerWithEmailAndPassword() async {
    firebaseUser.value = await AuthFirebaseRepository().registerWithEmailAndPassword(
      email: emailController.value.text, 
      password: passwordController.value.text,
    );
  }

  loginWithEmailAndPassword() async {
    firebaseUser.value = await AuthFirebaseRepository().loginWithEmailAndPassword(
      email: emailController.value.text, 
      password: passwordController.value.text,
    );
  }

  loginWithGoogle() async {
    firebaseUser.value = await AuthFirebaseRepository().sigInWithGoogle();
  }
}