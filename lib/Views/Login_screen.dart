import 'package:chatting_app/Helper/google_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../Controller/controller.dart';
import '../Controller/signUp_controller.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final signUpController = Get.put(SignUpController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(150, 120),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/pexels-photo-807598.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Login',
                    style: GoogleFonts.ubuntu(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF40744D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Sign in to continue',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: TextFormField(
                      controller: controller.txtemail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Color(0xFF40744D),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xFF40744D),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: TextFormField(
                        controller: controller.txtpass,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Color(0xFF40744D)),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFF40744D),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              signUpController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF40744D),
                            ),
                            onPressed: () {
                              signUpController.isPasswordVisible.value =
                                  !signUpController.isPasswordVisible.value;
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: !signUpController.isPasswordVisible.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () {
                      controller.signIn(controller.txtemail.text,
                          controller.txtpass.text, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF40744D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 80,
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SignInButton(Buttons.google, onPressed: () async {
                    await GoogleLoginServices.googleLoginServices
                        .signInWithGoogle();

                    // Check if the user is signed in
                    if (FirebaseAuth.instance.currentUser != null) {
                      print(
                          'User signed in: ${FirebaseAuth.instance.currentUser!.email}');
                      // Navigate to the next screen
                      Get.to(
                          const HomeScreen()); // Replace with your actual home screen
                    } else {
                      print('No user signed in');
                    }
                  }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Color(0xFF40744D)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
