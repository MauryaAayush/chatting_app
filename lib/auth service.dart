import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createAccountUsingEmail() async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: 'admin@gmail.com', password: '12345678');
  }
}
