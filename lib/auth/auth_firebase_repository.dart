import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_healthy_ai/services/services.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class AuthFirebaseRepository {
  final _validator = FormValidator();
  final _firestoreRepository = FirestoreRepository();

  Future<User?> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      if (await _firestoreRepository.isUsernameTaken(userName)) {
        _validator.showSnackbarError(
            'This username is taken. Please try another one.');
        return null;
      }
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(userName);
        await user.updatePhotoURL(
            "https://cdn.midjourney.com/b3b391ea-a529-4917-8f62-239e5d09db52/grid_0_640_N.webp");
        user = FirebaseAuth.instance.currentUser;

        if (user?.displayName == userName) {
          await _firestoreRepository.addUser(user!, "FirebaseAuth");
        }
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _validator.showSnackbarError('El correo electrónico ya está en uso.');
      } else if (e.code == 'weak-password') {
        _validator.showSnackbarError('La contraseña es muy débil.');
      }
      return null;
    } catch (e) {
      _validator.showSnackbarError(e.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      // Manejo de errores específicos de FirebaseAuth
      if (e.code == 'user-not-found') {
        _validator.showSnackbarError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _validator.showSnackbarError('Wrong password provided for that user.');
      } else if (e.code == 'user-disabled') {
        _validator.showSnackbarError("This user has been disabled.");
      } else {
        _validator.showSnackbarError("User credential is incorrect.");
      }
      return null;
    } catch (e) {
      // Captura de cualquier otro tipo de error
      _validator.showSnackbarError(e.toString());
      return null;
    }
  }

  Future<User?> sigInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          // Llamar a addUser para registrar o actualizar la información del usuario en Firestore
          await _firestoreRepository.addUser(user, "Google");
        }

        return user;
      } else {
        return null;
      }
    } catch (e) {
      _validator.showSnackbarError(e.toString());
      return null;
    }
  }
}
