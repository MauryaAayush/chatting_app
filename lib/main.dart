import 'package:chatting_app/Helper/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Views/Login_screen.dart';
import 'Views/home_screen.dart';
import 'Views/sigin_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => const AuthGate(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
          ),
          GetPage(
            name: '/login',
            page: () => LoginScreen(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
          ),
          GetPage(
            name: '/signup',
            page: () => SignUpPage(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
          ),
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}
