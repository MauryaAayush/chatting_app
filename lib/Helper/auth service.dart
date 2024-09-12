import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseAuthServices {
  static FirebaseAuthServices authServices = FirebaseAuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> createAccountUsingEmail(
      String email, String password, String name, String mobile, String image,
      ) async {
    log('------------------- Create function called--------------------------');

    try {
      log('------------------ Starting ---------------------------------');
      log("Sign Up Email : $email\nPassword : $password");

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      log('------------------ Credential done ---------------------------------');

      String? token = await FirebaseMessaging.instance.getToken();

      User? user = userCredential.user;
      if (user != null) {
        // Add user data to Firestore
        await firestore.collection('users').doc(user.email).set({
          'email': email,
          'name': name,
          'mobile': mobile,
          'image': image,
          'token' : token,
        });

        log("User created and data added to Firestore: ${user.email}");
      }
    } catch (e) {
      log("ERROR: $e");
      rethrow;  // Optionally rethrow to handle errors in the UI
    }
  }

  Future<User?> signIn(String email, String password) async {
    log("EMAIL: $email");
    log("Password: $password");
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user;
    } catch (e) {
      log("ERROR: $e");
      return null;  // Optionally rethrow if you need further error handling
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      log("ERROR: $e");
      return false;
    }
  }

  Future<void> sign_Out() async {
    await auth.signOut();
    if (auth.currentUser == null) {
      Get.back();
    }
  }
}
