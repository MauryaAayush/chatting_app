import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {

  static FirebaseAuthServices authServices = FirebaseAuthServices();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createAccountUsingEmail(String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(userCredential.user!.email);
  }

  Future<void> signIn(String email,String password)
  async {
    UserCredential userCredential  = await auth.signInWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    if(user!=null)
      {
        // home
      }
  }

}
