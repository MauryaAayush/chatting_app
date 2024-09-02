import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService{

  FirebaseMessagingService._();
  static FirebaseMessagingService firebaseMessagingService =
  FirebaseMessagingService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission()
  async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized)
    {
      log('Notification Permission Allowed !');
    } else if(settings.authorizationStatus == AuthorizationStatus.denied)
    {
      log('Notification Permission Denied');
    }
  }

  Future<void> generateDeviceToken()
  async {
    String? token=await _firebaseMessaging.getToken();
    // todo user cloud store -save
    log("Device Token:$token}");
  }




}