import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/UserData.dart';
import 'package:paysa/app.dart';
import 'package:paysa/firebase_options.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase initialize
  // THelperFunctions.hideBottomBlackStrip();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  log('Firebase app name: ${app.name}');

  Get.put(UserData());
  runApp(const App());
}
