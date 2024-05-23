import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:my_healthy_ai/auth/auth_firebase_repository.dart';
import 'package:my_healthy_ai/models/models.dart';
import 'package:my_healthy_ai/services/services.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isPassObscured = true.obs;
  RxBool isConfirmPassObscured = true.obs;
  Rxn<User?> firebaseUser = Rxn<User?>();
  Rxn<User?> tempUser = Rxn<User?>();
  RxList<Message> messages = <Message>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _authFirebaseRepository = AuthFirebaseRepository();
  final _validator = FormValidator();
  final _firestoreRepository = FirestoreRepository();

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

  updateFavouriteRecipe(RecetaApi receta) async {
    try {
      bool result = await _firestoreRepository.updateFavouriteRecipe(
        firebaseUser.value!,
        receta,
      );
      if (result) {
        _validator.showSnackbarSuccess("New favourite recipe added!");
      } else {
        _validator.showSnackbarError("Something was wrong. Try again later.");
      }
    } catch (e) {
      _validator.showSnackbarError(e.toString());
    }

    update();
  }

  Future<bool> deleteFavouriteRecipe(RecetaApi receta) async {
    try {
      bool result = await _firestoreRepository.deleteFavouriteRecipe(
        firebaseUser.value!,
        receta,
      );
      if (result) {
        _validator.showSnackbarSuccess("Favourite recipe deleted!");
        return true;
      } else {
        _validator.showSnackbarError("Something was wrong. Try again later.");
        return false;
      }
    } catch (e) {
      _validator.showSnackbarError(e.toString());
      return false;
    }
  }

  updateUsername() async {
    isLoading.value = true;
    try {
      tempUser.value = await _authFirebaseRepository.updateUsername(
        firebaseUser.value,
        usernameController.value.text,
      );
      if (tempUser.value != null && tempUser.value != firebaseUser.value) {
        firebaseUser.value = tempUser.value;
        Get.back();
        _validator.showSnackbarSuccess("Username updated!");
      } else {
        _validator
            .showSnackbarError("Username already taken. Try another one.");
      }
    } catch (e) {
      _validator.showSnackbarError(e.toString());
    } finally {
      usernameController.clear();
      isLoading.value = false;
    }
  }

  registerWithEmailAndPassword() async {
    isLoading.value = true;
    try {
      firebaseUser.value =
          await _authFirebaseRepository.registerWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
        userName: usernameController.value.text,
      );
      if (firebaseUser.value != null) {
        Get.offAllNamed('/verifyAccountScreen');
        _validator.showSnackbarSuccess("You are registered!");
      }
    } catch (e) {
      _validator.showSnackbarError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  verifyEmail() async {
    isLoading.value = true;
    try {
      _validator.showSnackbarSuccess("Email verification sent!");
      await firebaseUser.value?.sendEmailVerification();
      firebaseUser.value = _auth.currentUser;
      while (firebaseUser.value!.emailVerified == false) {
        await Future.delayed(const Duration(seconds: 5));
        await firebaseUser.value!.reload();
        firebaseUser.value = _auth.currentUser;
      }
      Get.offAllNamed('/homeScreen');
      _validator.showSnackbarSuccess("Email verified!");
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
          await _authFirebaseRepository.loginWithEmailAndPassword(
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
      firebaseUser.value = await _authFirebaseRepository.sigInWithGoogle();

      if (firebaseUser.value != null) {
        Get.offAllNamed('/homeScreen');
        _validator.showSnackbarSuccess("You are logged in!");
      } else {
        _validator.showSnackbarError("Google Sign In failed");
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

    messages.clear();
  }

  deleteAccount() async {
    try {
      await _authFirebaseRepository.deleteUser(firebaseUser.value!);
      Get.offAllNamed('/initialScreen');
      _validator.showSnackbarSuccess("Account deleted!");
    } catch (e) {
      _validator.showSnackbarError(e.toString());
    }
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

  String getUserCreationDate() {
    if (firebaseUser.value != null) {
      DateTime? creationDate = firebaseUser.value!.metadata.creationTime;
      String formattedDate = DateFormat('dd-MM-yy').format(creationDate!);
      return 'Registered since $formattedDate';
    } else {
      return 'No date';
    }
  }

  void sendMessage() async {
    isLoading.value = true;
    var message = Message(
      text: messageController.text,
      date: DateTime.now(),
      isSentByUser: true,
    );
    messages.add(message);
    messageController.clear();
    update();
    addMessageIA(message.text);
  }

  void addMessageIA(String message) async {
    var response = await sendMessageGemini(message);
    var messageIA = Message(
      text: response!,
      date: DateTime.now(),
      isSentByUser: false,
    );
    messages.add(messageIA);
    isLoading.value = false;
    update();
  }

  Future<String?> sendMessageGemini(String userMessage) async {
    try {
      final geminiApiKey = dotenv.env['GEMINI_API_KEY'];

      // For text-only input, use the gemini-pro model
      final generationConfig = GenerationConfig(
        maxOutputTokens: 1000,
        temperature: 0.5,
      );
      final model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: geminiApiKey!,
          generationConfig: generationConfig);
      final content = [Content.text(userMessage)];
      final response = await model.generateContent(content);
      return response.text!;
    } catch (e) {
      _validator.showSnackbarError(
          'My Healthy AI is not available now. Try again later.');
      isLoading.value = false;
    }
    return null;
  }
}
