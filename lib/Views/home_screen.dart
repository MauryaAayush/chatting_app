import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Controller/controller.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the AuthController using Get.put
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home, size: 24.r), // Responsive icon size
                    title: Text('Home', style: TextStyle(fontSize: 16.sp)), // Responsive font size
                    onTap: () {
                      Get.offNamed('/home');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, size: 24.r), // Responsive icon size
                    title: Text('Mobile Number', style: TextStyle(fontSize: 16.sp)), // Responsive font size
                    subtitle: Obx(() => Text(authController.phone.value)),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, size: 24.r), // Responsive icon size
                    title: Text('Settings', style: TextStyle(fontSize: 16.sp)), // Responsive font size
                    onTap: () {
                      Get.toNamed('/setting');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info, size: 24.r), // Responsive icon size
                    title: Text('About', style: TextStyle(fontSize: 16.sp)), // Responsive font size
                    onTap: () {
                      // Handle the about tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Screen', style: TextStyle(fontSize: 20.sp)), // Responsive font size
        actions: [
          IconButton(
            onPressed: () {
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
            icon: Icon(Icons.logout, size: 24.r), // Responsive icon size
          ),
        ],
      ),
      body: Center(
        child: Text('Home Screen', style: TextStyle(fontSize: 16.sp)), // Responsive font size
      ),
    );
  }
}
