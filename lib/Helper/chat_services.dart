import 'package:chatting_app/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Model/msg_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

// get user stream

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("users").snapshots().map(
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


  // we are going to create multiple chat rooms, for different user

// send message

  // lets go
  Future<void> sendMessage(String receiverID, message) async {
    //   for the current user info
    final String currentUserId = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // lets create a message

    Message newMessage = Message(
        senderID: currentUserId,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //  lets create a chat room ID  for the two user
    List<String> ids = [currentUserId, receiverID];

    ids.sort();
    String chatRoomID = ids.join('_');

    // add new msg to database Or start chatting
    await _firestore
        .collection("rooms")
        .doc(chatRoomID)
        .collection('message')
        .add(newMessage.toMap());
  }

static UserModel? receiverUserData;

  Future<void> getReceiverData(String receiverId) async {
    final receiverData = await _firestore.collection("users").doc(receiverId).get();
    receiverUserData = UserModel.fromMap(receiverData.data()!);
  }

// get message

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("rooms")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }


//   Update Message

  Future<void> updateMessage(String chatRoomID, String messageId, String newMessage) async {
    await _firestore
        .collection("rooms")
        .doc(chatRoomID)
        .collection("message")
        .doc(messageId)
        .update({'message': newMessage});
  }


//   Delete Screen

  Future<void> deleteMessage(String chatRoomID, String messageId) async {
    await _firestore
        .collection("rooms")
        .doc(chatRoomID)
        .collection("message")
        .doc(messageId)
        .delete();
  }
}

// flutter local notification