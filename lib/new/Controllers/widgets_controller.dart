import 'dart:io';

import 'package:davinci/core/davinci_capture.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';
import 'package:path_provider/path_provider.dart';

class WidgetsController {
  static Future<void> update(
      context, Widget widget, String androidWidget) async {
    Uint8List bytes = await DavinciCapture.offStage(widget,
        context: context,
        returnImageUint8List: true,
        wait: const Duration(seconds: 1),
        openFilePreview: true);

    final directory = await getApplicationSupportDirectory();
    File tempFile =
        File("${directory.path}/${DateTime.now().toIso8601String()}.png");
    await tempFile.writeAsBytes(bytes);

    await HomeWidget.saveWidgetData('filename', tempFile.path);
    await HomeWidget.updateWidget(androidName: androidWidget);
  }

  // background interactive callback
  // static Future<void> backgroundCallback(Map<String, dynamic> message) async {
  //   HomeWidget.registerInteractivityCallback(WidgetsController.interactivityCallback);
  //   print('backgroundCallback $message');
  // }

  static Future<void> initialize(String groupId) async {
    await HomeWidget.setAppGroupId(groupId);
  }
}
