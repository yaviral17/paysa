import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:paysa/main.dart';

class FirebaseAPI {
  // create ana instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    log('Requesting notification permission...');
    // request permission from user (will prompt a dialog)
    await _firebaseMessaging.requestPermission();

    log('Ensuring APNS token is available...');
    // Ensure the APNS token is available
    String? apnsToken = await _firebaseMessaging.getAPNSToken();
    while (apnsToken == null) {
      log('APNS token not available, retrying...');
      await Future.delayed(const Duration(seconds: 1));
      apnsToken = await _firebaseMessaging.getAPNSToken();
    }
    log('APNS token available.');

    // fetch the FCM token for this device
    log('Fetching FCM token...');
    final fcmToken = await _firebaseMessaging.getToken();
    // print the token (normally you would send this to your server)
    log("Token: $fcmToken");

    // initialize further settings for push notifications
    log('Initializing push notifications...');
    await initPushNotifications();
    log('Push notifications initialized.');
  }

  //function to handle received notifications
  void handleMessages(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState!.pushNamed('/dashboard', arguments: message);
  }

  // function to initialize foreground and background notifications
  Future<void> initPushNotifications() async {
    log('Handling initial message...');
    // handle notifications if the app was terminated and opened
    _firebaseMessaging.getInitialMessage().then(handleMessages);

    log('Attaching event listeners...');
    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }
}
