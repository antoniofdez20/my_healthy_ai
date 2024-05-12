import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/models/models.dart';
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
                        user.value?.displayName ?? 'No name',
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
                () => ListView.builder(
                  itemCount: recetasController.recetas.length,
                  itemBuilder: (context, index) {
                    final receta = recetasController.recetas[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        onTap: () {
                          recetasController.tempReceta.value =
                              Receta.fromJson(receta);
                          Get.toNamed('/detailsScreen');
                        },
                        leading: Image.asset(receta['image']),
                        title: Text(receta['title']),
                        subtitle: Text(receta['description']),
                        trailing: IconButton(
                          icon: receta['isFavourite']
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border),
                          onPressed: () =>
                              recetasController.toggleFavourite(index),
                        ),
                      ),
                    );
                  },
                ),
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
