import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/utils/utils.dart';
import 'package:my_healthy_ai/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.firebaseUser;
    final recetasController = Get.find<RecetasController>();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: user.value?.photoURL != null
                      ? CachedNetworkImageProvider(user.value!.photoURL!)
                      : const AssetImage('assets/img/avatar_user.png')
                          as ImageProvider,
                ),
                Column(
                  children: [
                    Obx(
                      () => Text(
                        _getFirstName(user.value?.displayName),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      authController.getUserCreationDate(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _bottomSheet(context, authController),
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () async {
                            await authController.signOut();
                            Get.offAllNamed('/initialScreen');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Favourite Recipes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Obx(
                () {
                  if (recetasController.favouriteRecipes.isEmpty) {
                    return const Center(
                      child: Text('No favourite recipes yet'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: recetasController.favouriteRecipes.length,
                      itemBuilder: (context, index) {
                        final receta =
                            recetasController.favouriteRecipes[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            onTap: () {
                              recetasController.tempReceta.value = receta;
                              Get.toNamed('/detailsScreen');
                            },
                            leading: receta.image != null
                                ? FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/img/receta_placeholder.png'),
                                    image: NetworkImage(receta.image!),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/img/receta_placeholder.png'); // O cualquier otro widget de error
                                    },
                                  )
                                : Image.asset(
                                    'assets/img/receta_placeholder.png'),
                            title: Text(receta.label),
                            subtitle: Text(
                                'Calories: ${receta.calories.toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: recetasController
                                      .isRecipeFavourite(receta.label)
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : const Icon(Icons.favorite_border),
                              onPressed: () async {
                                if (recetasController
                                    .isRecipeFavourite(receta.label)) {
                                  final result = await authController
                                      .deleteFavouriteRecipe(receta);
                                  if (result) {
                                    recetasController.favouriteRecipes
                                        .removeWhere((element) =>
                                            element.label == receta.label);
                                  }
                                } else {
                                  recetasController.favouriteRecipes
                                      .add(receta);
                                  authController.updateFavouriteRecipe(receta);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        user: authController.firebaseUser.value,
      ),
    );
  }

  _bottomSheet(BuildContext context, AuthController authController) {
    Get.bottomSheet(
      SizedBox(
        height: 250,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(
                controller: authController.usernameController,
                hintTextCustom: 'New Username',
              ),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: authController.isLoading.value
                    ? null
                    : () async {
                        await authController.updateUsername();
                      },
                child: authController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Update Username'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: MyColors.azure,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}

_getFirstName(String? fullName) {
  if (fullName == null || fullName.isEmpty) {
    return 'No name';
  }
  int firstSpace = fullName.indexOf(' ');
  if (firstSpace == -1) {
    // No space found, return the full name
    return fullName;
  }
  return fullName.substring(0, firstSpace);
}
