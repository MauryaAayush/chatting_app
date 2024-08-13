import 'package:chatting_app/Helper/auth%20service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home Screen'),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuthServices.authServices.sign_Out();

                  Get.back();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: const Center(child: Text('Home Screen')));
  }
}
