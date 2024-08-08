import 'package:chatting_app/Helper/auth%20service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Views/home_screen.dart';

class AuthController extends GetxController {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();

  Future<void> signUp(String email, String pass) async {
    try {
      bool emailExists = await FirebaseAuthServices.authServices.checkEmailExists(email);
      if (emailExists) {
        Get.snackbar(
          'Sign Up Failed',
          'Email already in use. Please use a different email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        await FirebaseAuthServices.authServices.createAccountUsingEmail(email, pass);
        Get.snackbar(
          'Sign Up',
          'Sign Up Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signIn(String email, String pass) async {
    try {
      User? user = await FirebaseAuthServices.authServices.signIn(email, pass);
      if (user != null) {
        // Navigate to home screen
        Get.to(const HomeScreen());
      } else {
        Get.snackbar(
          'Login Failed',
          'Incorrect email or password.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
