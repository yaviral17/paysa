import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paysa/Utils/theme/colors.dart';

class PHelper {
  // Check if the current theme is dark
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static void systemUIOverlayStyle(BuildContext context,
      {Color? statusBarColor, Color? systemNavigationBarColor}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: statusBarColor ?? PColors.background(context),
        systemNavigationBarColor:
            systemNavigationBarColor ?? PColors.background(context),
        // statusBarBrightness: Brightness.light,
        statusBarIconBrightness:
            PHelper.isDarkMode(context) ? Brightness.light : Brightness.dark,
        // systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: PColors.background(context),
        systemNavigationBarIconBrightness:
            PHelper.isDarkMode(context) ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
