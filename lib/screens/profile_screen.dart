import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.firebaseUser.value;
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
                  backgroundImage: user?.photoURL != null
                      ? CachedNetworkImageProvider(user!.photoURL!)
                      : const AssetImage('assets/img/avatar_user.png')
                          as ImageProvider,
                ),
                Column(
                  children: [
                    Text(
                      user?.displayName ?? 'No name',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      authController.getUserCreationDate(),
                      style: const TextStyle(fontSize: 10),
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
}
