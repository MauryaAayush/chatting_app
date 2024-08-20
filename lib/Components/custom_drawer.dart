import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Controller/controller.dart';
import '../Views/Login_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //   logo
              DrawerHeader(
                child: Obx(
                      () => Column(
                    children: [
                      CircleAvatar(
                        radius: 28.r, // Responsive radius
                        backgroundImage: NetworkImage(authController.url.value),
                      ),
                      SizedBox(height: 16.h), // Responsive height
                      Text(
                        authController.name.value,
                        style: TextStyle(
                          fontSize: 20.sp, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        authController.email.value,
                        style: TextStyle(
                          fontSize: 15.sp, // Responsive font size
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              //   home list tile
              // Divider(
              //   height: 1,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.home, size: 24.r,color: Theme.of(context).colorScheme.primary,), // Responsive icon size
                  title: const Text('H O M E'), // Responsive font size
                  onTap: () {
                    Get.offNamed('/home');
                  },
                ),
              ),
              //    setting list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.call, size: 24.r,color: Theme.of(context).colorScheme.primary,), // Responsive icon size
                  title: Obx(() => Text(authController.mobile.value,)), // Responsive font size
                  // subtitle:
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.settings, size: 24.r,color: Theme.of(context).colorScheme.primary,), // Responsive icon size
                  title: const Text('S E T T I N G S'), // Responsive font size
                  onTap: () {
                    Get.toNamed('/setting');
                  },
                ),

              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              title: const Text('L O G O U T'),
              leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.primary,),
              onTap: () {
                authController.logOut();
                Fluttertoast.showToast(
                  msg: "Logged out successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.sp, // Responsive font size
                );
                Get.off(() => LoginScreen());
              },

              // onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
