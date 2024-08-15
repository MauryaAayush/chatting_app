import 'package:chatting_app/Helper/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const AuthGate(),
          transition: Transition.fadeIn, // Set transition type
          transitionDuration: const Duration(milliseconds: 500), // Set duration
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          transition: Transition.fadeIn, // Set transition type
          transitionDuration: const Duration(milliseconds: 500), // Set duration
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpPage(),
          transition: Transition.fadeIn, // Set transition type
          transitionDuration: const Duration(milliseconds: 500), // Set duration
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          transition: Transition.fadeIn, // Set transition type
          transitionDuration: const Duration(milliseconds: 500), // Set duration
        ),
      ],
    );
  }
}
