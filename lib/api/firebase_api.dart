import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:paysa/main.dart';

class FirebaseAPI {
  // create ana instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    // request permission from user (will prompt a dialog)
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device
    final FCMToken = await _firebaseMessaging.getToken();
    // print the token (normally you would send this to your server)
    log("Token: $FCMToken");

    // initialize further settings for push notifications]
    initPushNotifications();
  }

  //function to handle received notifications
  void handleMessages(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState!.pushNamed('/dashboard', arguments: message);
  }
  // function to initialize foreground and background notifications

  Future initPushNotifications() async {
    // handle notifications if the app was terminated and opened
    _firebaseMessaging.getInitialMessage().then(handleMessages);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }
}
