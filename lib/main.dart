import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
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
  await requestStoragePermission();
  await FirebaseAPI().initNotifications();

  // Check and request storage permission

  log('Firebase app name: ${app.name}');

  runApp(const App());
}

Future<void> requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.status;
  if (status.isGranted) {
    log('Storage permission granted');
  }
  if (!status.isGranted) {
    status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      // Handle the case when the user denies the permission
      // You can show a dialog or a message to the user
      log('Storage permission denied');
    }
  }
}
