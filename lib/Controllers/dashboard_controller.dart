import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Utils/constants/flags.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

  PageController pageController = PageController(initialPage: 0);

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void nextPage() {
    currentIndex.value++;
    pageController.animateToPage(currentIndex.value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void previousPage() {
    currentIndex.value--;
    pageController.animateToPage(currentIndex.value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
