import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:paysa/app.dart';

class PFirebaseAPI {
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  // Flag to track if a permission request is in progress
  bool _permissionRequestInProgress = false;

  // function to initialize notifications
  Future<String> initNotifications() async {
    // Check if a permission request is already in progress
    if (_permissionRequestInProgress) {
      log('Permission request already in progress, waiting...');
      return '';
    }

    _permissionRequestInProgress = true;
    try {
      // Request permission from user (will prompt a dialog on iOS)
      if (Platform.isIOS) {
        log('Requesting permission for iOS...');
        // Request permission for iOS
        await Future.delayed(const Duration(seconds: 1));
        NotificationSettings settings =
            await _firebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          provisional: false,
          sound: true,
        );
        log('User granted permission: ${settings.authorizationStatus}');
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          log('Ensuring APNS token is available...');
          // Ensure the APNS token is available for iOS
          String? apnsToken = await _firebaseMessaging.getAPNSToken();
          int attempts = 0;
          while (apnsToken == null && attempts < 5) {
            // Limit retries to avoid infinite loop
            log('APNS token not available, retrying... (${attempts + 1}/5)');
            await Future.delayed(const Duration(seconds: 1));
            apnsToken = await _firebaseMessaging.getAPNSToken();
            attempts++;
          }
          if (apnsToken != null) {
            log('APNS token available: $apnsToken');
            return apnsToken;
          }
        }
      } else {
        log('Requesting permission for Android...');
        // Request permission for Android
        await Future.delayed(const Duration(seconds: 1));
        NotificationSettings settings =
            await _firebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          provisional: false,
          sound: true,
        );

        log('User granted permission: ${settings.authorizationStatus}');
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          final fcmToken = await _firebaseMessaging.getToken();
          log("FCM Token: $fcmToken");

          // Initialize further settings for push notifications
          log('Initializing push notifications...');
          await initPushNotifications();

          return fcmToken ?? '';
        }
      }

      return '';
    } finally {
      _permissionRequestInProgress = false;
    }
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
