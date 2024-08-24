import 'package:chatting_app/Components/chat_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Components/msg_textfield.dart';
import '../Helper/auth service.dart';
import '../Helper/chat_services.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;
  final String name;

  const ChatScreen({super.key, required this.receiverEmail, required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  //  chat & auth service
  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _authService = FirebaseAuthServices();

  Future<void> sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverEmail, _messageController.text);
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from HomeScreen
    // final arguments = Get.arguments as Map<String, dynamic>;
    // final String name = arguments['name'] ?? 'No Name';
    // final String email = arguments['email'] ?? 'No Email';
    // final String receiverID = arguments['uid'] ?? 'No UID';




    Widget buildMessageList() {
      String senderID = _authService.getCurrentUser()!.email!;
      return StreamBuilder(
        stream: _chatService.getMessage(widget.receiverEmail, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                'Loading.....',
                style: TextStyle(fontSize: 20.sp),
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          //   display all message

          Expanded(
            child: buildMessageList(),
          ),

          //   user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    String currentUserEmail = _authService.getCurrentUser()!.email!;
    String senderId = data["senderID"] ?? "no id";
    print("Current User Email: $currentUserEmail");
    print("Message Sender ID: $senderId");

    bool isCurrentUser = senderId == currentUserEmail;

    // print(isCurrentUser);
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,

        children: [
          ChatContainer(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          //  textfield should take up most of the space
          Expanded(
            child: MyTextField(
              hintText: "Type a message",
              obscureText: false,
              controller: _messageController,
              // focusNode: myFocusNode,
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () async {
                if (_messageController.text.isNotEmpty) {
                  // send the message
                  await _chatService.sendMessage(
                      widget.receiverEmail, _messageController.text);
                  //   clear text controller
                  _messageController.clear();
                }
              },
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
