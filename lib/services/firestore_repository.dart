import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_healthy_ai/models/models.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _validator = FormValidator();

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

  Future<String?> checkIfRecipeExists(RecetaApi receta) async {
    QuerySnapshot query = await _firestore
        .collection('recetas')
        .where('label', isEqualTo: receta.label)
        .get();

    // Si la consulta devuelve documentos, la receta ya existe
    if (query.docs.isNotEmpty) {
      return query.docs.first.id;
    } else {
      return null;
    }
  }

  Future<bool> deleteFavouriteRecipe(User user, RecetaApi receta) async {
    String? recipeId = await checkIfRecipeExists(receta);
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.uid);
      await userDocRef.update({
        'recetas_favoritas': FieldValue.arrayRemove([recipeId])
      });
      return true;
    } catch (e) {
      _validator.showSnackbarError(
          "Failed to delete favourite recipe: ${e.toString()}");
      return false;
    }
  }

  Future<String?> addRecipe(RecetaApi receta) async {
    try {
      Map<String, dynamic> recetaMap = receta.toJson();

      DocumentReference docRef =
          await _firestore.collection('recetas').add(recetaMap);
      return docRef.id;
    } catch (e) {
      _validator.showSnackbarError("Failed to persist recipe: ${e.toString()}");
      return null;
    }
  }

  Future<void> updateUser(User user, String newUsername) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.uid);
      await userDocRef.update({'username': user.displayName ?? newUsername});
    } catch (e) {
      _validator.showSnackbarError("Failed to persist user: ${e.toString()}");
    }
  }

  Future<bool> updateFavouriteRecipe(User user, RecetaApi receta) async {
    try {
      String? recipeId = await checkIfRecipeExists(receta);
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.uid);

      if (recipeId != null) {
        // La receta ya existe, añadir el ID a las recetas favoritas del usuario
        await userDocRef.update({
          'recetas_favoritas': FieldValue.arrayUnion([recipeId])
        });
        return true;
      } else {
        // La receta no existe, añadirla a la colección y luego actualizar el usuario
        String? newRecipeId = await addRecipe(receta);
        if (newRecipeId != null && newRecipeId.isNotEmpty) {
          await userDocRef.update({
            'recetas_favoritas': FieldValue.arrayUnion([newRecipeId])
          });
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      _validator.showSnackbarError(
          "Failed to update favourite recipe: ${e.toString()}");
      return false;
    }
  }

  Future<bool> isUsernameTaken(String username) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<void> deleteAccount(User user) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.uid);
      await userDocRef.delete();
    } catch (e) {
      _validator.showSnackbarError("Failed to delete account: ${e.toString()}");
    }
  }

  Future<List<RecetaApi>> getFavouriteRecipes(User user) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      List<String> favoriteRecipeIds =
          List<String>.from(userDoc['recetas_favoritas']);
      if (favoriteRecipeIds.isEmpty) {
        return [];
      }

      List<RecetaApi> favoriteRecipes = [];
      for (String id in favoriteRecipeIds) {
        DocumentSnapshot recipeDoc =
            await _firestore.collection('recetas').doc(id).get();
        if (recipeDoc.exists) {
          favoriteRecipes.add(
              RecetaApi.fromJson(recipeDoc.data() as Map<String, dynamic>));
        }
      }

      return favoriteRecipes;
    } else {
      return [];
    }
  }
}
