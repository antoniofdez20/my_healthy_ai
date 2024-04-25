import 'package:firebase_auth/firebase_auth.dart';

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
}