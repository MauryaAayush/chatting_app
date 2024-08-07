
import 'package:chatting_app/auth%20service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

TextEditingController txtemail = TextEditingController();
TextEditingController txtpass = TextEditingController();


Future<void> singUp(String email,String pass) async {

  await FirebaseAuthServices.authServices.createAccountUsingEmail(email,pass);
}

}