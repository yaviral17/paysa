import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavigationController extends GetxController {
  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    update();
  }

  void nextPage() {
    currentIndex++;
    update();
  }

  void previousPage() {
    currentIndex--;
    update();
  }
}
