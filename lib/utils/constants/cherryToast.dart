import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';

void showErrorToast(
  BuildContext context,
  String message, {
  double? width,
  String? title,
  bool? displayTitle,
  Color? titleColor,
  Color? messageColor,
  Position? position = Position.top,
  Duration? duration = const Duration(milliseconds: 1000),
  Color? backgroundColor,
  double? height,
  Cubic? animationCurve,
}) {
  CherryToast.error(
    title: Text(message,
        style: TextStyle(
          color: titleColor ?? Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
    // iconWidget: Icon(
    //   Icons.error,
    //   color: Colors.red,
    // ),
    toastPosition: position ?? Position.top,
    width: width,

    displayIcon: displayTitle ?? true,
    // description: Text(title ?? "",
    //     style: TextStyle(color: messageColor ?? Colors.black)),
    animationType: AnimationType.fromRight,
    animationDuration: duration!,
    autoDismiss: true,
    backgroundColor: backgroundColor ?? PColors.light,
    height: height,
    animationCurve: animationCurve ?? Curves.ease,
  ).show(context);
}

void showSuccessToast(
  BuildContext context,
  String message, {
  double? width,
  String? title,
  bool? displayTitle,
  Color? titleColor,
  Color? messageColor,
  Position? position = Position.top,
  Duration? duration = const Duration(milliseconds: 1000),
  Color? backgroundColor,
  double? height,
  Cubic? animationCurve,
}) {
  CherryToast.success(
    title: Text(message,
        style: TextStyle(
          color: titleColor ?? Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
    toastPosition: position ?? Position.top,
    width: width,
    displayIcon: displayTitle ?? true,
    // description:
    //     Text(message, style: TextStyle(color: messageColor ?? Colors.black)),
    animationType: AnimationType.fromRight,
    animationDuration: duration!,
    autoDismiss: true,
    backgroundColor: backgroundColor ?? PColors.light,
    height: height,
    animationCurve: animationCurve ?? Curves.ease,
  ).show(context);
}
