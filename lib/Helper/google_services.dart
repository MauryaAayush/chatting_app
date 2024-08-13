
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginServices{
  static GoogleLoginServices googleLoginServices = GoogleLoginServices._();
  GoogleLoginServices._();

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!
          .authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      // final UserCredential userCredential = await FirebaseAuth.instance
      //     .signInWithCredential(credential);

      await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }

  User? currentUser() {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      print(user.email);
      print(user.displayName);
      print(user.phoneNumber);
      print(user.photoURL);
    }
    return user;
  }

  void logOut() async {
    googleSignIn.signOut();
    firebaseAuth.signOut();
  }

}