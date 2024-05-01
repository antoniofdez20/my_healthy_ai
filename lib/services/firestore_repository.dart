import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(User user, String loginMethod) async {
    DocumentReference userDocRef = _firestore.collection('users').doc(user.uid);
    await userDocRef.set({
      'username': user.displayName ?? 'N/A',
      'email': user.email,
      'profile_picture': user.photoURL ??
          'https://cdn.midjourney.com/b3b391ea-a529-4917-8f62-239e5d09db52/grid_0_640_N.webp',
      'login_method': loginMethod,
      'recetas_favoritas': []
    }, SetOptions(merge: true));
  }

  Future<bool> isUsernameTaken(String username) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<void> deleteAccount(User user) async {
    DocumentReference userDocRef = _firestore.collection('users').doc(user.uid);
    await userDocRef.delete();
  }
}
