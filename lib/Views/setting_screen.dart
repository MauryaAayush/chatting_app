import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/theme_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeController
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: themeController.isDark
              ? Theme.of(context).colorScheme.primary
              : Color(0xFF117554),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark Theme",style: TextStyle(color: Colors.white),),
            CupertinoSwitch(
              value: themeController.isDark,
              onChanged: (value) => themeController.toggleTheme(),
              activeColor: Color(0xFF117554),
              offLabelColor: Colors.white,
              focusColor: Colors.white,
              onLabelColor: Colors.white,
              trackColor: Colors.grey,
            ),
          ],
        ),
      ),
    ));
  }
}
