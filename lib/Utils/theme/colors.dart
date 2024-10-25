import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paysa/Utils/helpers/helper.dart';

class PColors {
  // Constant colors
  static const Color transparent = Color(0x00000000);

  // App theme colors
  static const Color primaryLight = Color(0xFF2EAB57);
  static const Color primaryDark = Color(0xFF0C0C0C);
  static Color primary(context) {
    // not keeping variation for primary color
    return PHelper.isDarkMode(context) ? primaryLight : primaryLight;
  }

  //background colors
  static const Color backgroundLight = Color(0xFFf4f3f7);
  static const Color backgroundDark = Color(0xFF0C0C0C);

  static Color background(context) {
    return PHelper.isDarkMode(context) ? backgroundDark : backgroundLight;
  }

  // Text colors
  static const Color primaryTextLight = Color(0xFF000000);
  static const Color primaryTextDark = Color(0xFFFFFFFF);
  static Color primaryText(context) {
    return PHelper.isDarkMode(context) ? primaryTextDark : primaryTextLight;
  }

  //secondary text color
  static const Color secondaryTextLight = Color(0xFF8E8E93);
  static const Color secondaryTextDark = Color(0xFF8E8E93);
  static Color secondaryText(context) {
    return PHelper.isDarkMode(context) ? secondaryTextDark : secondaryTextLight;
  }

  // loading indicator color
  // not applicable for now
  static const Color loadingIndicatorLight = Color(0xFFFFFFFF);
  static const Color loadingIndicatorDark = Color(0xFFFFFFFF);
  static Color loadingIndicator(context) {
    return PHelper.isDarkMode(context)
        ? loadingIndicatorDark
        : loadingIndicatorLight;
  }

  //add more on the go

  static const Color success = Color(0xFF2EAB57);
  static const Color error = Color(0xFFB00020);

  static const Color black = Color(0xFF000000);
}
