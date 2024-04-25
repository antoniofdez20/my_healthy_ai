import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebaseRepository {
  Future<User?> registerWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return user;

    } catch (e) {
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return user;

    } catch (e) {
      return null;
    }
  }

  Future<User?> sigInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential).then((UserCredential userCredential) {
        User? user = userCredential.user;
        return user;
      });
    } catch (e) {
      return null;
    }
  }
}