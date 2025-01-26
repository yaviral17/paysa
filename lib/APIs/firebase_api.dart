import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:paysa/app.dart';

class PFirebaseAPI {
  // create ana instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<String> initNotifications() async {
    // Request permission from user (will prompt a dialog on iOS)
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    log('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (Platform.isIOS) {
        log('Ensuring APNS token is available...');
        // Ensure the APNS token is available for iOS
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        while (apnsToken == null) {
          log('APNS token not available, retrying...');
          await Future.delayed(const Duration(seconds: 1));
          apnsToken = await _firebaseMessaging.getAPNSToken();
        }
        log('APNS token available: $apnsToken');
      }

      // Fetch the FCM token for this device
      log('Fetching FCM token...');
      final fcmToken = await _firebaseMessaging.getToken();
      log("FCM Token: $fcmToken");

      // Initialize further settings for push notifications
      log('Initializing push notifications...');
      await initPushNotifications();

      return fcmToken!;
    } else {
      log('User declined or has not accepted permission');
    }

    return '';
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
