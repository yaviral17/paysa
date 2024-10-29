import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/app.dart';

void main() {
  // defining screen size for mobile
  PSize.screenWidth = 420;
  PSize.screenHeight = 840;

  runApp(const MyApp());
}
