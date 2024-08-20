import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

// get user stream

/*
  List<Map<String,dynamic>> =
  [
  {
  'email : admin@gmail.com',
  'id' : ....
  },
   {
  'email : aayush@gmail.com',
  'id' : ....
  },
  ]
 */

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("users").snapshots().map(
          (snapshot) {
        return snapshot.docs.map(
              (doc) {
            //  go through each individual user
            final user = doc.data();

            //   return user
            return user;
          },
        ).toList();
      },
    );
  }

// send message

// get message

}