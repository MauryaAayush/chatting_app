import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Helper/auth service.dart';
import '../Helper/chat_services.dart';

class ChatScreen extends StatefulWidget {
  // final String receiverEmail;
  // final String receiverID;

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  //  chat & auth service
  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _authService = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from HomeScreen
    final arguments = Get.arguments as Map<String, dynamic>;
    final String name = arguments['name'] ?? 'No Name';
    final String email = arguments['email'] ?? 'No Email';
    final String receiverID = arguments['uid'] ?? 'No UID';

    Widget buildMessageList() {
      String senderID = _authService.getCurrentUser()!.uid;
      return StreamBuilder(
        stream: _chatService.getMessage(receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading.....',style: TextStyle(
                fontSize: 20.sp
              ),),
            );
          }

          return ListView(
            // children: snapshot.data!.docs
            //     .map((doc) => _buildMessageItem(doc))
            //     .toList(),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          //   display all message

          Expanded(
            child: buildMessageList(),
          ),

          //   user input
          // _buildUserInput(),
        ],
      ),
    );
  }

  // Widget _buildMessageItem(DocumentSnapshot doc){
  //
  // }
  //
  // Widget _buildUserInput(){
  //
  // }

}
