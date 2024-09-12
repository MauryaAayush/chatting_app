import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';

class FirebaseMessagingServices {
  FirebaseMessagingServices._();

  static final FirebaseMessagingServices firebaseMessagingServices =
  FirebaseMessagingServices._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initializeFirebaseMessaging() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log("Initial Message: ${message.data}");
      }
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token!;
  }

  void onMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("OnMessage: ${message.data}");
      await FirebaseMessagingServices.firebaseMessagingServices
          .showSimpleNotification(message);
    });
  }

  void onMessageOpenedAppListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("OnMessageOpenedApp: ${message.data}");
    });
  }

  Future<void> showSimpleNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'firebase chat',
      'firebase chat notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      2,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
    );
  }
}
