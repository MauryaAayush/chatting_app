
import 'package:chatting_app/Helper/auth%20service.dart';
import 'package:chatting_app/Controller/controller.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {


    var controller = AuthController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login'),),
      
      body: Column(
       children: [
         TextField(
           controller: controller.txtemail,
          decoration: const InputDecoration(
            border: OutlineInputBorder(

            )
          ),
         ),
         const SizedBox(
           height: 20,
         ),
         TextField(
           controller: controller.txtpass,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
            )
          ),
         ),
         const SizedBox(
           height: 20,
         ),
         ElevatedButton(onPressed: () {
           // firebaseAuthServices.createAccountUsingEmail();

           controller.singUp(controller.txtemail.text,controller.txtpass.text);

         }, child: const Text('Create a account'))
       ], 
      ),
      
    );
  }
}

FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();