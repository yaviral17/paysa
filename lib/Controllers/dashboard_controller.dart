import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    currentIndex.value++;
  }

  void previousPage() {
    currentIndex.value--;
    update();
  }
}
