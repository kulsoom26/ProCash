import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyOnBoarding = GlobalKey<ScaffoldState>();
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
