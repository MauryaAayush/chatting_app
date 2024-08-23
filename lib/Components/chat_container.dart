

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/theme_controller.dart';

class ChatContainer extends StatelessWidget {

  final String message;
  final bool isCurrentUser;

  const ChatContainer({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {

    final ThemeController themeController = Get.put(ThemeController());

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),

      decoration: BoxDecoration(
          color: isCurrentUser
              ? (themeController.isDark ? Colors.green.shade600 : Colors.green.shade500)
              : (themeController.isDark ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Text(
        message,
        style: TextStyle(
            color: isCurrentUser
                ? Colors.white
                : (themeController.isDark ? Colors.white : Colors.black)
        ),
      ),
    );
  }
}
