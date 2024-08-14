import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:paysa/utils/constants/cherryToast.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static String getDateDifference(DateTime date) {
    final Duration difference = DateTime.now().difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  static String getDayDifference(DateTime date) {
    final Duration difference = DateTime.now().difference(date);
    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return THelperFunctions.formateDateTime(date, "d MMM yyyy");
    }
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static hideBottomBlackStrip() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
      ],
    );
  }

  static void showMaterialSnakBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  static String formateDateTime(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime getDateTimeFromFormatedString(
      String dateTime, String format) {
    return DateFormat(format).parse(dateTime);
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
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Your Image',
          toolbarColor: TColors.darkBackground,
          cropGridColor: TColors.darkBackground,
          statusBarColor: TColors.lightDarkBackground,
          cropFrameColor: Theme.of(context).colorScheme.primary,
          showCropGrid: false,
          toolbarWidgetColor: TColors.light,
          backgroundColor: TColors.darkBackground,
          dimmedLayerColor: TColors.darkBackground,
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
        backgroundColor: TColors.primary,
        backgroundGradient: LinearGradient(
          colors: [
            TColors.primary,
            TColors.primary,
            Colors.blue.shade900,
          ],
        ),
      );
      return null;
    }

    XFile? image = await THelperFunctions.pickImage(fromCamera: isCamera);
    if (image == null) {
      showErrorToast(context, "Please select an image");
      return null;
    }
    File? croppedImage = await THelperFunctions.startImageCrop(image, context);
    if (croppedImage == null) return File(image.path);
    return croppedImage;
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void copyToClipBoard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    showSuccessToast(context, "Copied to clipboard");
  }

  static bool validateEmail(String email) {
    final emailPattern = RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$',
        caseSensitive: false);
    return emailPattern.hasMatch(email);
  }

  static void showErrorMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: TColors.error,
      colorText: TColors.light,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showSuccessMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: TColors.success,
      colorText: TColors.light,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showWarningMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: TColors.warning,
      colorText: TColors.light,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showInfoMessageGet({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: TColors.info,
      colorText: TColors.light,
      snackPosition: SnackPosition.TOP,
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  Future requestStoragePermission() async {
    const platform = MethodChannel(
        'com.shreyxnsh.androidstorage.android_12_flutter_storage/storage');
    try {
      await platform.invokeMethod('requestStoragePermission');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static AESEncription(String text) {
    final key = encrypt.Key.fromUtf8(getKey());
    final iv = encrypt.IV.fromLength(128);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    final encryptedString = encrypted.base64;
    log('Encrypted: $encryptedString');
    return encryptedString;
  }

  static AESDecription(String text) {
    final key = encrypt.Key.fromUtf8(getKey());
    final iv = encrypt.IV.fromLength(128);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encryptedData = encrypt.Encrypted.fromBase64(text);
    final decrypted = encrypter.decrypt(encryptedData, iv: iv);
    log('Decrypted: $decrypted');
    return decrypted;
  }

  static String encryptAES(String text, String key) {
    return text;
  }

  static String testAES(String text) {
    final key = encrypt.Key.fromUtf8(getKey());
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    final encryptedString = encrypted.base64;
    log('Encrypted: $encryptedString');
    return encryptedString;
  }

  // show date time dialog box and return date and time in DateTime format
  static Future<DateTime?> showDateTimeDialog(BuildContext context) async {
    DateTime? selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedDate = picked;
    }
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      selectedTime = pickedTime;
    }
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  static String getKey() {
    // random key of 128 bits
    String key = '';
    for (var i = 0; i < 128; i++) {
      key += i.toString();
    }
    return key;
  }
}
