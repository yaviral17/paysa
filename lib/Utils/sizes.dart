import 'package:flutter/material.dart';

class PSize {
  static double? screenHeight;
  static double? screenWidth;

  // Function to get the screen height
  static double displayHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Function to get the screen width
  static double displayWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  //rh = responsive height
  static double rh(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * (height / screenHeight!);
  }

  //arh = adaptive responsive height
  static double arh(BuildContext context, double height) {
    return MediaQuery.of(context).size.height > screenHeight!
        ? height
        : MediaQuery.of(context).size.height * (height / screenHeight!);
  }

  //rw = responsive width
  static double rw(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * (width / screenWidth!);
  }

  //arw = adaptive responsive width
  static double arw(BuildContext context, double width) {
    return MediaQuery.of(context).size.width > screenWidth!
        ? width
        : MediaQuery.of(context).size.width * (width / screenWidth!);
  }
}
