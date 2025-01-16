import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paysa/api/firebase_api.dart';
import 'package:paysa/app.dart';
import 'package:paysa/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<PermissionStatus> requestPhotoPermission() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    Permission permissionToRequest;

    if (androidInfo.version.sdkInt <= 32) {
      permissionToRequest = Permission.storage;
    } else {
      permissionToRequest = Permission.photos;
    }

    return permissionToRequest.request();
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    log('Requesting photo permission for iOS');
    return Permission.photos.request();
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // firebase initialize
  // // THelperFunctions.hideBottomBlackStrip();
  // final app = await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await requestPhotoPermission();
  // await FirebaseAPI().initNotifications();

  // // Check and request storage permission

  // log('Firebase app name: ${app.name}');

  // runApp(const App());
  try {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('Firebase initialized: ${app.name}');

    log('Requesting photo permission...');
    await requestPhotoPermission();
    log('Photo permission granted.');

    log('Initializing notifications...');
    await FirebaseAPI().initNotifications();
    log('Notifications initialized.');

    runApp(const App());
  } catch (e, stackTrace) {
    log('Error during initialization: $e');
    log('Stack trace: $stackTrace');
  }
}
