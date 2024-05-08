import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/utils/utils.dart';

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
            icon: Icon(
              Icons.home,
              color: currentRoute != '/homeScreen' ? null : MyColors.mint,
            ),
            onPressed: () {
              if (currentRoute != '/homeScreen') {
                Get.offAllNamed('/homeScreen');
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.wechat,
              color: currentRoute != '/chatScreen' ? null : MyColors.mint,
            ), // o tambien el icono adb
            onPressed: () {
              if (currentRoute != '/chatScreen') {
                Get.offAllNamed('/chatScreen');
              }
            },
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
              /* child: ClipOval(
                child: user?.photoURL != null
                    ? FadeInImage(
                        placeholder:
                            const AssetImage('assets/img/avatar_user.png')
                                as ImageProvider,
                        image: Image.network(user!.photoURL!).image,
                      )
                    : const Image(
                        image: AssetImage('assets/img/avatar_user.png'),
                      ),
              ), */
            ),
          ),
        ],
      ),
    );
  }
}
