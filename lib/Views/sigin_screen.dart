import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/controller.dart';
import 'Login_screen.dart';

class SignUpController extends GetxController {
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var agreeToTerms = false.obs;
}

class SignUpPage extends StatelessWidget {
  final signUpController = Get.put(SignUpController());

  SignUpPage({Key? key}) : super(key: key);

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
                        bottomRight: Radius.elliptical(150, 120),
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
                    'Create Account',
                    style: GoogleFonts.ubuntu(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF40744D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Sign up to get started',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: const TextStyle(
                        color: Color(0xFF40744D),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
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
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: TextFormField(
                      controller: controller.txtemail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFF40744D),
                        ),
                        prefixIcon: Icon(
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
                  SizedBox(height: 20),
                  Obx(
                        () => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: TextFormField(
                        controller: controller.txtpass,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color(0xFF40744D)),
                          prefixIcon:
                          Icon(Icons.lock, color: Color(0xFF40744D)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              signUpController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF40744D),
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
                  SizedBox(height: 20),
                  Obx(
                        () => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Color(0xFF40744D)),
                          prefixIcon:
                          Icon(Icons.lock, color: Color(0xFF40744D)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              signUpController.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF40744D),
                            ),
                            onPressed: () {
                              signUpController.isConfirmPasswordVisible.value =
                              !signUpController
                                  .isConfirmPasswordVisible.value;
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText:
                        !signUpController.isConfirmPasswordVisible.value,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Obx(
                            () => Checkbox(
                          value: signUpController.agreeToTerms.value,
                          onChanged: (value) {
                            signUpController.agreeToTerms.value = value!;
                          },
                          activeColor: Color(0xFF40744D),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'I agree to the Terms and Conditions',
                          style: TextStyle(color: Color(0xFF40744D)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: ElevatedButton(
                      onPressed: () {
                        if (signUpController.agreeToTerms.value) {
                          controller.signUp(
                            controller.txtemail.text,
                            controller.txtpass.text,
                          );
                        } else {
                          Get.snackbar(
                            'Terms and Conditions',
                            'You must agree to the terms and conditions to sign up.',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF40744D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Color(0xFF40744D)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
