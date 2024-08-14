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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase initialize
  // THelperFunctions.hideBottomBlackStrip();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await requestPhotoPermission();
  await FirebaseAPI().initNotifications();

  // Check and request storage permission

  log('Firebase app name: ${app.name}');

  runApp(const App());
}

Future<PermissionStatus> requestPhotoPermission() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  Permission permissionToRequest;

  if (defaultTargetPlatform == TargetPlatform.android &&
      androidInfo.version.sdkInt <= 32) {
    permissionToRequest = Permission.storage;
  } else {
    permissionToRequest = Permission.photos;
  }

  if (await permissionToRequest.status.isDenied) {
    return await permissionToRequest.request();
  }
  log('Storage permission denied');
  return permissionToRequest.status;
}
