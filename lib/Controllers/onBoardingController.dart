import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Models/onBoardingPage.dart';

class onBoardingControllers extends GetxController {
  var selectedPageIndex = 0.obs;
  var pageController = PageController();
  bool get isLastPage => selectedPageIndex.value == 2;

  void forwardAction() {
    if (selectedPageIndex.value ==
        OnboardingPageModel.getOnboardingPages().length - 1) {
      // Get.offAllNamed(Routes.LOGIN);
      return;
    }
    pageController.animateToPage(
      ++selectedPageIndex.value,
      duration: 300.milliseconds,
      curve: Curves.easeIn,
    );
    // selectedPageIndex.value++;
  }

  void backAction() {
    if (selectedPageIndex.value == 0) {
      // Get.offAllNamed(Routes.LOGIN);
      return;
    }

    pageController.animateToPage(
      --selectedPageIndex.value,
      duration: 300.milliseconds,
      curve: Curves.easeIn,
    );
  }
}
