import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../Components/custom_button.dart';
import '../Components/custom_textfield.dart';
import '../Controller/controller.dart';
import '../Controller/signIn_and_signUp_controller.dart';
import '../Helper/google_services.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final authController = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200.h,
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
                  SizedBox(height: 30.h),
                  Text(
                    'Login',
                    style: GoogleFonts.ubuntu(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF40744D),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Log in to continue',
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomTextField(
                    controller: loginController.txtemail,
                    label: 'Email',
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                        () => CustomTextField(
                      label: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: loginController.isPasswordVisible.value,
                      controller: loginController.txtpass,

                    ),
                  ),
                  SizedBox(height: 28.h),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      authController.signIn(
                        loginController.txtemail.text,
                        loginController.txtpass.text,
                        context,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          'OR',
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
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
                  SizedBox(height: 20.h),
                  SignInButton(
                    Buttons.google,
                    onPressed: () async {
                      await GoogleLoginServices.googleLoginServices.signInWithGoogle();
                      if (FirebaseAuth.instance.currentUser != null) {
                        print('User signed in: ${FirebaseAuth.instance.currentUser!.email}');
                        Get.off(
                          const HomeScreen(),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 500),
                        );
                      } else {
                        print('No user signed in');
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: const Color(0xFF40744D),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
