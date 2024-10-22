import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SafetyStockSettingsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeySafetyStockSettings = GlobalKey<ScaffoldState>();
  final switchController = ValueNotifier<bool>(false);
 
  @override
  void onInit() {
    super.onInit();
  }
}
