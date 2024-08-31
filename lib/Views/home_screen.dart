import 'package:chatting_app/Views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Components/custom_drawer.dart';
import '../Components/user_title.dart';
import '../Controller/controller.dart';
import '../Helper/auth service.dart';
import '../Helper/chat_services.dart';
import '../Helper/notification_services.dart';
import 'Login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _authService = FirebaseAuthServices();
  final NotificationServices _notificationServices = NotificationServices();

  final Map<String, String> _lastMessageIds = {}; // Track the last message ID for each user
  bool _isChatScreenActive = false;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      drawer: CustomDrawer(authController: authController),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Screen', style: TextStyle(fontSize: 20.sp)),
        actions: [
          IconButton(
            onPressed: () {
              authController.logOut();
              Fluttertoast.showToast(
                msg: "Logged out successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.sp,
              );
              Get.off(() => LoginScreen());
            },
            icon: Icon(Icons.logout, size: 24.r),
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  void _listenForNewMessages(String receiverEmail, String receiverName) {
    String senderID = _authService.getCurrentUser()!.email!;
    _chatService.getMessage(receiverEmail, senderID).listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var lastMessageData = snapshot.docs.last.data();
        String newMessageId = snapshot.docs.last.id;

        // Track the last message ID for this particular receiver
        if (_lastMessageIds[receiverEmail] != newMessageId && !_isChatScreenActive) {
          String messageContent = lastMessageData['message'] ?? 'New message';

          _notificationServices.showNotification(
            newMessageId.hashCode,
            receiverName,
            messageContent,
          );

          _lastMessageIds[receiverEmail] = newMessageId; // Update last message ID for this receiver
        }
      }
    });
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    String currentUserEmail = _authService.getCurrentUser()!.email!;

    if (userData['email'] != currentUserEmail) {
      return UserTile(
        text: userData["name"] ?? 'No Name',
        subtitle: userData["mobile"] ?? '86049492**',
        imageUrl: userData["image"] ?? 'https://via.placeholder.com/150',
        onTap: () {
          _isChatScreenActive = true;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                receiverEmail: userData['email'],
                name: userData['name'],
              ),
            ),
          ).then((_) {
            _isChatScreenActive = false;
          });

          _listenForNewMessages(userData['email'], userData['name'] ?? 'No Name');
        },
      );
    }
    return Container();
  }
}
