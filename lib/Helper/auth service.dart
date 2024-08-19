import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseAuthServices {
  static FirebaseAuthServices authServices = FirebaseAuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createAccountUsingEmail(
      String email, String password, String name, String mobile) async {

    print('-------------------create function called--------------------------');

    // ye call ho raha hai
    try {
      print('------------------ Starting---------------------------------');
      log("Sign Up Email : $email\n Password : $password");
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // ye call hi nhi ho raha

      print('------------------ Credential done---------------------------------');

      User? user = userCredential.user;
      if (user != null) {
        // Add user data to Firestore
        await firestore.collection('users').doc(user.email).set({
          'email': email,
          'name': name,
          'mobile': mobile,
          'createdAt': Timestamp.now(),
        });
        // ye call hi nhi ho raha
        print("User created and data added to Firestore: ${user.email}");
      }
    } catch (e) {
     log("ERROR : $e");
    }
  }

  Future<User?> signIn(String email, String password) async {
    log("EMAIL : $email");
    log("Password : $password");
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Chat GPT sir Nice

  Future<bool> checkEmailExists(String email) async {
    try {
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }


  Future<void> sign_Out() async {
    await auth.signOut();
    User? user = auth.currentUser;
    if (user == null) {
      Get.back();
    }
  }
}
