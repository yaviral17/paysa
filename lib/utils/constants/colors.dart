import 'package:flutter/material.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class PColors {
  // App theme colors
  static const Color primary = Color(0xFF2EAB57);
  static const Color primaryDark = Color(0xFF0C0C0C);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);
  static const Color transparent = Colors.transparent;

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // text field colors
  static const Color lightTextField = Color(0xFFE0E0E0);
  static const Color darkTextField = Color(0xFF161515);
  static Color textField(BuildContext context) {
    return THelperFunctions.isDarkMode(context)
        ? darkTextField
        : lightTextField;
  }

  // Background colors
  static const Color light = Color(0xFFF5F7FB);
  // static const Color dark = Color(0xFF272727);
  static const Color dark = Color(0xFF0C0C0C);
  static const Color primaryBackground = Color(0xFFF3F5FF);
  static const Color darkBackground = Colors.black12;

  // Light and Dark Background colors
  static const Color lightBackground = Color(0xFFf4f3f7);
  static const Color lightDarkBackground = Color(0xFF172F53);
  static Color background(BuildContext context) {
    return THelperFunctions.isDarkMode(context)
        ? darkBackground
        : lightBackground;
  }

  // Background Container colors
  static const Color lightContainer = Color(0xFFF5F7FB);
  static Color darkContainer = PColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  // Bottom bar colors
  static const Color lightBottomBar = Color(0xFFE0E0E0);
  static const Color darkBottomBar = Color(0xFF1A1919);
  static Color bottomBar(BuildContext context) {
    return THelperFunctions.isDarkMode(context)
        ? darkBottomBar
        : lightBottomBar;
  }

  // bottom nav item colors
  static const Color lightBottomNavItemActive = Color(0xFF4b68ff);
  static const Color darkBottomNavItemActive = Color(0xFF4b68ff);
  static Color bottomNavItemActive(BuildContext context) {
    return THelperFunctions.isDarkMode(context)
        ? darkBottomNavItemActive
        : lightBottomNavItemActive;
  }

  static const Color lightBottomNavItemInactive = Color(0xFF6C757D);
  static const Color darkBottomNavItemInactive = Color(0xFF6C757D);
  static Color bottomNavItemInactive(BuildContext context) {
    return THelperFunctions.isDarkMode(context)
        ? darkBottomNavItemInactive
        : lightBottomNavItemInactive;
  }
}
