import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/UserData.dart';
import 'package:paysa/app.dart';
import 'package:paysa/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase initialize
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(UserData());
  runApp(const App());
}
