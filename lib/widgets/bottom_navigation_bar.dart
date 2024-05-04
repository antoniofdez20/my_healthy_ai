import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationBar extends StatelessWidget {
  final User? user;
  const CustomNavigationBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String currentRoute = Get.currentRoute;
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              if (currentRoute != '/homeScreen') {
                Get.offNamed('/homeScreen');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.wechat), // o tambien el icono adb
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {
              if (currentRoute != '/profileScreen') {
                Get.offAllNamed('/profileScreen');
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: user?.photoURL != null
                  ? CachedNetworkImageProvider(user!.photoURL!)
                  : const AssetImage('assets/img/avatar_user.png')
                      as ImageProvider,
            ),
          ),
        ],
      ),
    );
  }
}
