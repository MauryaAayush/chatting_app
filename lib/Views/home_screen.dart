import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Components/custom_drawer.dart';
import '../Controller/controller.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the AuthController using Get.put
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      drawer: CustomDrawer(authController: authController),
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


