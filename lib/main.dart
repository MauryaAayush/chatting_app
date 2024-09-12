import 'package:chatting_app/Helper/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Controller/theme_controller.dart';
import 'Helper/firebase_msg_service.dart';
import 'Helper/google_notification.dart';
import 'Views/Login_screen.dart';
import 'Views/home_screen.dart';
import 'Views/setting_screen.dart';
import 'Views/signUp_screen.dart';
import 'firebase_options.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.notification!.title}");
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Get.to(const UserPage());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingService.firebaseMessagingService.requestPermission();
  await FirebaseMessagingService.firebaseMessagingService.generateDeviceToken();

  await FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessagingServices.firebaseMessagingServices.onMessageListener();

  // call onBackgroundMessage from FirebaseMessaging and pass background message handler which above created
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // String? token = await FirebaseMessaging.instance.getToken();
  // print(token);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // Access the ThemeController
    final ThemeController themeController = Get.put(ThemeController());

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Obx(() => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.themeData,
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
            page: () => HomeScreen(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
          ),
          GetPage(
            name: '/setting',
            page: () => const SettingScreen(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
          ),
          // GetPage(
          //   name: '/chat',
          //   page: () =>  const ChatScreen(),
          //   transition: Transition.rightToLeft,
          //   transitionDuration: const Duration(milliseconds: 500),
          // ),
        ],
      )),
    );
  }
}
