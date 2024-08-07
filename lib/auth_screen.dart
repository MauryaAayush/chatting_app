import 'package:chatting_app/auth%20service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),),
      
      body: Column(
       children: [
         TextField(),
         TextField(),
         
         ElevatedButton(onPressed: () {
           firebaseAuthServices.createAccountUsingEmail();
         }, child: Text('Create a account'))
       ], 
      ),
      
    );
  }
}

FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();