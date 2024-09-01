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

  final Map<String, String> _lastMessageIds = {};

  bool _isChatScreenActive = false;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      drawer: CustomDrawer(authController: authController),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home Screen',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
            icon: Icon(Icons.logout, size: 24.r, color: Colors.white),
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
          return Center(child: Text('Error', style: TextStyle(color: Colors.red)));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: EdgeInsets.all(8.0),
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

        if (_lastMessageIds[receiverEmail] != newMessageId && !_isChatScreenActive) {
          String messageContent = lastMessageData['message'] ?? 'New message';

          _notificationServices.showNotification(
            newMessageId.hashCode,
            receiverName,
            messageContent,
          );

          _lastMessageIds[receiverEmail] = newMessageId;
        }
      }
    });
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    String currentUserEmail = _authService.getCurrentUser()!.email!;

    if (userData['email'] != currentUserEmail) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          elevation: 4.0,
          child: ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(userData["image"] ?? 'https://via.placeholder.com/150'),
            ),
            title: Text(
              userData["name"] ?? 'No Name',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(userData["mobile"] ?? '86049492**'),
            trailing: Icon(Icons.chat, color: Colors.blueAccent, size: 24.r),
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
          ),
        ),
      );
    }
    return Container();
  }
}
