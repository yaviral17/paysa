import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:iconsax/iconsax.dart';
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

  static void showSuccessMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: PColors.success,
      colorText: PColors.backgroundLight,
      overlayBlur: 4,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(18),
      animationDuration: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1400),
      icon: const Icon(
        Icons.check_circle_rounded,
        color: PColors.backgroundLight,
        size: 32,
      ),
    );
  }

  static void showErrorMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: PColors.error,
      colorText: PColors.backgroundLight,
      barBlur: 20,
      overlayBlur: 4,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(18),
      animationDuration: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1400),
      icon: const Icon(
        Iconsax.info_circle,
        color: PColors.backgroundLight,
        size: 32,
      ),
    );
  }

  static void showWarningMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: PColors.warningTostColor,
      colorText: PColors.backgroundLight,
      barBlur: 20,
      overlayBlur: 4,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(18),
      animationDuration: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1400),
      icon: const Icon(
        Icons.warning_rounded,
        color: PColors.backgroundLight,
        size: 32,
      ),
    );
  }

  static void showInfoMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: PColors.infoTostColor,
      colorText: PColors.backgroundLight,
      barBlur: 20,
      overlayBlur: 4,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(18),
      animationDuration: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1400),
      icon: const Icon(
        Icons.error,
        color: PColors.backgroundLight,
        size: 32,
      ),
    );
  }
}
