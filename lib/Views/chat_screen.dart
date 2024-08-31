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

  const ChatScreen({
    super.key,
    required this.receiverEmail,
    required this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _authService = FirebaseAuthServices();

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverEmail, _messageController.text);
      _messageController.clear();
    }
  }

  Widget buildMessageList() {
    String senderID = _authService.getCurrentUser()!.email!;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverEmail, senderID),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text(
              'Loading.....',
              style: TextStyle(fontSize: 20.sp),
            ),
          );
        }

        if (snapshot.hasData) {
          final List<DocumentSnapshot> docs = snapshot.data!.docs;

          return ListView(
            children: docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        } else {
          return const Center(child: Text('No messages yet'));
        }
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String currentUserEmail = _authService.getCurrentUser()!.email!;
    String senderId = data["senderID"] ?? "no id";
    bool isCurrentUser = senderId == currentUserEmail;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPress: isCurrentUser
                ? () {
              _showMessageOptions(context, doc.id, data['message']);
            }
                : null,
            child: ChatContainer(
              message: data["message"],
              isCurrentUser: isCurrentUser,
            ),
          ),
        ],
      ),
    );
  }

  void _showMessageOptions(BuildContext context, String messageId, String currentMessage) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 50, 50), // Adjust position as needed
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _editMessage(messageId, currentMessage);
            },
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              _deleteMessage(messageId);
            },
          ),
        ),
      ],
    );
  }

  void _editMessage(String messageId, String currentMessage) {
    TextEditingController _editController = TextEditingController(text: currentMessage);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Message'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(hintText: 'Enter new message'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_editController.text.isNotEmpty) {
                  String senderID = _authService.getCurrentUser()!.email!;
                  List<String> ids = [widget.receiverEmail, senderID];
                  ids.sort();
                  String chatRoomID = ids.join('_');

                  await _chatService.updateMessage(chatRoomID, messageId, _editController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteMessage(String messageId) async {
    String senderID = _authService.getCurrentUser()!.email!;
    List<String> ids = [widget.receiverEmail, senderID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _chatService.deleteMessage(chatRoomID, messageId);
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              hintText: "Type a message",
              obscureText: false,
              controller: _messageController,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
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

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }
}
