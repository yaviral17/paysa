import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/app.dart';
import 'package:paysa/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authController = Get.put(AuthenticationController());
  // defining screen size for mobile
  PSize.screenWidth = 420;
  PSize.screenHeight = 840;

  runApp(const MyApp());
}
