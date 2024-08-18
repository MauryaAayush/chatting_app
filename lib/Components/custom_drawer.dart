import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/controller.dart';

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
                  title: Obx(() => Text(authController.phone.value,)), // Responsive font size
                  // subtitle:
                ),

              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.settings, size: 24.r,color: Theme.of(context).colorScheme.primary,), // Responsive icon size
                  title: Text('S E T T I N G S'), // Responsive font size
                  onTap: () {
                    Get.toNamed('/setting');
                  },
                ),

              ),
            ],
          ),
          //   logoutlist tile
          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              title: const Text('L O G O U T'),
              leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.primary,),
              // onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}


// Column(
// children: [
// DrawerHeader(
// child: Obx(
// () => Column(
// children: [
// CircleAvatar(
// radius: 28.r, // Responsive radius
// backgroundImage: NetworkImage(authController.url.value),
// ),
// SizedBox(height: 16.h), // Responsive height
// Text(
// authController.name.value,
// style: TextStyle(
// fontSize: 20.sp, // Responsive font size
// fontWeight: FontWeight.bold,
// ),
// overflow: TextOverflow.ellipsis,
// ),
// Text(
// authController.email.value,
// style: TextStyle(
// fontSize: 15.sp, // Responsive font size
// color: Colors.grey,
// ),
// overflow: TextOverflow.ellipsis,
// ),
// ],
// ),
// ),
// ),
//
// Expanded(
// child: ListView(
// padding: EdgeInsets.zero,
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 25),
// child: ListTile(
// leading: Icon(
// Icons.home,
// size: 24.r,
// color: Theme.of(context).colorScheme.primary,
// ),
// title: Text('Home', style: TextStyle(fontSize: 16.sp)),
// onTap: () {
// Get.offNamed('/home');
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(left: 25),
// child: ListTile(
// leading: Icon(
// Icons.phone,
// size: 24.r,
// color: Theme.of(context).colorScheme.primary,
// ),
// title: Text('Mobile Number', style: TextStyle(fontSize: 16.sp)),
// subtitle: Obx(() => Text(authController.phone.value)),
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(left: 25),
// child: ListTile(
// leading: Icon(
// Icons.settings,
// size: 24.r,
// color: Theme.of(context).colorScheme.primary,
// ),
// title: Text('Settings', style: TextStyle(fontSize: 16.sp)),
// onTap: () {
// Get.toNamed('/setting');
// },
// ),
// ),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(left: 25, bottom: 10),
// child: ListTile(
// leading: Icon(
// Icons.logout,
// size: 24.r,
// color: Theme.of(context).colorScheme.primary,
// ),
// title: Text('Logout', style: TextStyle(fontSize: 16.sp)),
// onTap: () {
// // Handle the logout tap
// },
// ),
// ),
// ],
// ),