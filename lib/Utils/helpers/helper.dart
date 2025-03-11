import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class PHelper {
  // Check if the current theme is dark
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isPlatformIos(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  static String convertToCurrency(double amount, String from, String to) {
    return amount.toStringAsFixed(2);
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

  static Future<XFile?> pickImage({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    Permission permissionToRequest;
    if (fromCamera) {
      // get camera permission if not granted
      PermissionStatus status = await Permission.camera.request();
      if (!status.isGranted) {
        Get.snackbar("Error", "Please grant camera permission");
        return null;
      }

      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return null;
      return image;
    } else {
      // get storage permission if not granted
      requestPhotoPermission();
      if (defaultTargetPlatform == TargetPlatform.android &&
          androidInfo.version.sdkInt <= 32) {
        permissionToRequest = Permission.storage;
      } else {
        permissionToRequest = Permission.photos;
      }
      if (await permissionToRequest.status.isDenied) {
        Get.snackbar("Error", "Please grant storage permission");
        return null;
      }

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return image;
    }
  }

  static Future<File?> pickImageWithCrop(
      BuildContext context, bool isCamera) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    Permission permissionToRequest;
    if (defaultTargetPlatform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 32) {
      permissionToRequest = Permission.storage;
    } else {
      permissionToRequest = Permission.photos;
    }
    final status = await permissionToRequest.request();
    log('Storage permission status: $status');
    if (status.isDenied) {
      Get.snackbar(
        "Storage Permission not provided",
        "Please grant storage permission",
        backgroundColor: PColors.primary(context),
        backgroundGradient: LinearGradient(
          colors: [
            PColors.primary(context),
            PColors.primary(context),
            Colors.blue.shade900,
          ],
        ),
      );
      return null;
    }

    XFile? image = await PHelper.pickImage(fromCamera: isCamera);
    if (image == null) {
      showErrorMessageGet(
        title: "Error",
        message: "No image selected",
      );
      return null;
    }
    File? croppedImage = await PHelper.startImageCrop(image, context);
    if (croppedImage == null) return File(image.path);
    return croppedImage;
  }

  static Future<File?> startImageCrop(
      XFile imageFile, BuildContext context) async {
    File imageTemporary = File(imageFile.path);
    final Directory extdir = await getApplicationDocumentsDirectory();
    String duplicateFilePath = extdir.path;
    final fileName = path.basename(imageTemporary.path);
    final saveto = '$duplicateFilePath/$fileName';
    final File newImage = await imageTemporary.copy(saveto);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: newImage.path,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9
      // ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Your Image',
          toolbarColor: PColors.background(context),
          cropGridColor: PColors.background(context),
          statusBarColor: PColors.primaryText(context),
          cropFrameColor: Theme.of(context).colorScheme.primary,
          showCropGrid: false,
          toolbarWidgetColor: PColors.primaryText(context),
          backgroundColor: PColors.background(context),
          dimmedLayerColor: PColors.background(context),
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        // ignore: use_build_context_synchronously
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return File(croppedFile!.path);
  }

  static Future<PermissionStatus> requestPhotoPermission() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    Permission permissionToRequest;

    if (defaultTargetPlatform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 32) {
      permissionToRequest = Permission.storage;
    } else {
      permissionToRequest = Permission.photos;
    }

    if (await permissionToRequest.status.isDenied) {
      return await permissionToRequest.request();
    }
    log('Storage permission denied');
    return permissionToRequest.status;
  }

  bool isImage(File file) {
    final ext = file.path.toLowerCase();
    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png') ||
        ext.endsWith('.gif') ||
        ext.endsWith('.bmp') ||
        ext.endsWith('.webp');
  }

  bool isPdf(File file) {
    return file.path.toLowerCase().endsWith('.pdf');
  }
}
