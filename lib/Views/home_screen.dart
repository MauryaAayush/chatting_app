import 'package:chatting_app/Helper/get_server_token.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Components/custom_drawer.dart';
import '../Controller/controller.dart';
import '../Controller/theme_controller.dart';
import '../Helper/auth service.dart';
import '../Helper/chat_services.dart';
import '../Helper/notification_services.dart';
import 'Login_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _authService = FirebaseAuthServices();
  final NotificationServices _notificationServices = NotificationServices();
  final ThemeController themeController = Get.put(ThemeController());

  final Map<String, String> _lastMessageIds = {};

  // Track the last message ID for each user
  bool _isChatScreenActive = false;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      drawer: CustomDrawer(authController: authController),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: themeController.isDark
                    ? Theme.of(context).colorScheme.primary
                    : Color(0xFF117554),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   GetServerToken.instance.getServerToken();
      // },),


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
          return const Text('Loading...', style: TextStyle(color: Colors.white));
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
      return ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(userData["image"] ?? 'https://via.placeholder.com/150'),
        ),
        title: Text(
          userData["name"] ?? 'No Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          userData["mobile"] ?? '86049492**',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '12:35',
              style: TextStyle(color: Colors.grey),
            ),


          ],
        ),
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
