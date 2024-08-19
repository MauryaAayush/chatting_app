import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseAuthServices {
  static FirebaseAuthServices authServices = FirebaseAuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createAccountUsingEmail(String email, String password, String name, String mobile) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        // Add user data to Firestore
        await firestore.collection('users').doc(user.uid).set({
          'email': email,
          'name': name,
          'mobile': mobile,
          'createdAt': Timestamp.now(),
          // Add any additional fields you want to store
        });
        print("User created and data added to Firestore: ${user.email}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

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
