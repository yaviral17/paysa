import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/firebase_api.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/app.dart';
import 'package:paysa/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final authController = Get.put(AuthenticationController());

  if (FirebaseAuth.instance.currentUser != null) {
    PFirebaseAPI().initNotifications().then(
      (token) {
        log('FCM Token: $token');
        if (token.isNotEmpty) {
          FirestoreAPIs.addFcmToken(
              FirebaseAuth.instance.currentUser!.uid, token);
        }
      },
    );
    authController.user.value = await FirestoreAPIs.getUser();
  }

  // defining screen size for mobile
  PSize.screenWidth = 420;
  PSize.screenHeight = 840;

  runApp(const MyApp());
}
