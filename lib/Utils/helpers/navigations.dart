// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PNavigate {
  // material page route with right transition animation
  static void to(Widget widget, {BuildContext? context}) {
    Navigator.of(context ?? Get.context!).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  // material page route with right transition animation
  static void back({BuildContext? context}) {
    if (context == null) {
      Get.back();
      return;
    }
    Navigator.of(context).pop();
  }

  // material page route with right transition animation
  static void toAndRemoveUntil(Widget widget, {BuildContext? context}) {
    Navigator.of(context ?? Get.context!).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  // material page route with right transition animation
  static void toAndReplace(Widget widget, {BuildContext? context}) {
    Navigator.of(context ?? Get.context!).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static void fadeTo(Widget child) {
    Get.to(
      () => child,
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 200),
    );
  }

  static void materialFade(Widget child) {
    Navigator.of(Get.context!).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          animation.drive(tween);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static void materialFadeReplacement(Widget child) {
    Navigator.of(Get.context!).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  // material to right single replacement
  static void materialToRightOneReplacement(Widget child) {
    Navigator.of(Get.context!).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  // material to right
  static void materialToRight(Widget child) {
    Navigator.of(Get.context!).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

// clear all previous screens and fade to new screen
  static void fadeToReplacement(Widget child) {
    Get.offAll(
      () => child,
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 200),
    );
  }

  // fade right to new screen
  static void fadeToRight(Widget child) {
    Get.to(
      () => child,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 200),
    );
  }

  // fade back to previous screen
  static void fadeBack() {
    Get.back();
  }

  static void materialFadeBack({BuildContext? context}) {
    Navigator.of(context ?? Get.context!).pop();
  }

  static void fadeLeftToReplacement(Widget child) {
    Get.offAll(
      () => child,
      transition: Transition.leftToRight,
      duration: const Duration(milliseconds: 200),
    );
  }

  // clear navigation stack
  static void clearNavigationStack(Widget child) {
    Get.offAll(
      () => child,
      transition: Transition.noTransition,
      duration: const Duration(milliseconds: 200),
    );
  }
}
