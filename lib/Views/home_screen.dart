import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Components/custom_drawer.dart';
import '../Components/user_title.dart';
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
        // Responsive font size
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
        //   error
        if (snapshot.hasError) {
          return const Text('Error');
        }
        //   loading....
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        //   return list view
        return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData,context))
                .toList());
      },
    );
  }

//   build individual list tile for the user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //   display all the user  except  current user
    if(userData['email'] != _authService.getCurrentUser()?.email){
      return UserTile(
        // textnum: userData['mobile'],
        text: userData["email"],
        onTap: () {

          Get.toNamed('/chat');
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ChatScreen(
          //         // Username: userData["name"],
          //         receiverID: userData["uid"],
          //         receiverEmail: userData["email"],
          //       ),
          //     ));
        },
      );
    }else{
      return Container();
    }
  }
}
