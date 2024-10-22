import 'package:get/get.dart';

class SelectModeController extends GetxController {
  var selectedIndex = 0.obs;

  void selectMode(int index) {
    selectedIndex.value = index;
  }
}
