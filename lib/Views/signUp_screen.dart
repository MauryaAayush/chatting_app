import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_button.dart';
import '../Components/custom_textfield.dart';
import '../Controller/controller.dart';
import '../Controller/signIn_and_signUp_controller.dart';

class SignUpPage extends StatelessWidget {
  final signUpController = Get.put(SignUpController());

  SignUpPage({super.key});

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
                    height: 180.h,
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
                  SizedBox(height: 30.h),
                  Text(
                    'Create Account',
                    style: GoogleFonts.ubuntu(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF40744D),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Sign up to get started',
                    style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                   CustomTextField(
                    label: 'Full Name',
                    prefixIcon: Icons.person,
                    controller: controller.txtname, hintText: 'Enter your name',
                  ),
                  CustomTextField(
                    controller: controller.txtmobile,
                    label: 'Phone',
                    prefixIcon: Icons.phone, hintText: 'Enter your Mobile Number',
                  ),
                  CustomTextField(
                    controller: controller.txtemail,
                    label: 'Email',
                    prefixIcon: Icons.email, hintText: 'Enter your email',

                  ),
                  Obx(
                    () => CustomTextField(
                      controller: controller.txtpass,
                      label: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: !signUpController.isPasswordVisible.value,
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
                      ), hintText: 'Enter your password',
                    ),
                  ),
                  Obx(
                    () => CustomTextField(
                      label: 'Confirm Password',
                      prefixIcon: Icons.lock,
                      obscureText:
                          !signUpController.isConfirmPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          signUpController.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF40744D),
                        ),
                        onPressed: () {
                          signUpController.isConfirmPasswordVisible.value =
                              !signUpController.isConfirmPasswordVisible.value;
                        },
                      ), hintText: 'Re-Write password',
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: signUpController.agreeToTerms.value,
                          onChanged: (value) {
                            signUpController.agreeToTerms.value = value!;
                          },
                          activeColor: const Color(0xFF40744D),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'I agree to the Terms and Conditions',
                          style: TextStyle(color: Color(0xFF40744D)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      if (signUpController.agreeToTerms.value) {
                        controller.signUp(
                          controller.txtname.text,
                          controller.txtmobile.text,
                          controller.txtemail.text,
                          controller.txtpass.text,
                            "https://cdn.pixabay.com/photo/2013/07/12/14/36/man-148582_1280.png"
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
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: const Text(
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
