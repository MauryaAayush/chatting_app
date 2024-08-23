import 'package:chatting_app/Views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Components/custom_drawer.dart';
import '../Components/user_title.dart'; // Assuming this is a custom widget to display user details
import '../Controller/controller.dart';
import '../Helper/auth service.dart';
import '../Helper/chat_services.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _authService = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    // Initialize the AuthController using Get.put
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
                fontSize: 16.sp, // Responsive font size
              );
              Get.off(() => LoginScreen());
            },
            icon: Icon(Icons.logout, size: 24.r), // Responsive icon size
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
        // Error
        if (snapshot.hasError) {
          return const Text('Error');
        }
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        // Return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // Build individual list tile for the user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // Display all users except the current user
    if (userData['email'] != _authService.getCurrentUser()?.email) {
      return UserTile(
        text: userData["name"] ?? 'No Name',
        subtitle: userData["mobile"] ?? '86049492**',
        // Assuming UserTile has a subtitle parameter
        imageUrl: userData["image"] ?? 'https://via.placeholder.com/150',
        // Assuming UserTile has an imageUrl parameter
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(
                receiverEmail: userData['email'],
                name: userData['name'],
            ),
          ));

          // Get.toNamed('/chat', arguments: {
          //   'name': userData['name'],
          //   'email': userData['email'],
          //   'receiverID' : userData['uid']
          // });
          // // Alternatively, you can use the commented-out Navigator.push logic if needed
        },
      );
    } else {
      return Container();
    }
  }
}
