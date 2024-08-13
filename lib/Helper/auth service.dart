import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  static FirebaseAuthServices authServices = FirebaseAuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  Future<void> createAccountUsingEmail(String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(userCredential.user!.email);
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


  Future signInWithGoogle() async{

    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //
    // // Obtain the auth details from the request
    // final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    //
    // // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
   try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
    } catch (e) {
     print(e.toString());
   }

    // return await FirebaseAuth.instance.signInWithCredential(credential);

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
    await googleSignIn.signOut();
    User? user = auth.currentUser;
    if (user == null) {
      Get.back();
    }
  }

}
