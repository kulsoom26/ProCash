import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditHomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyEditHome = GlobalKey<ScaffoldState>();
  
  var homeWidgets = <String>[].obs;

  void addWidget(String widgetTitle) {
    if (!homeWidgets.contains(widgetTitle)) {
      homeWidgets.add(widgetTitle);
    }
  }

  void removeWidget(String widgetTitle) {
    if (homeWidgets.contains(widgetTitle)) {
      homeWidgets.remove(widgetTitle);
    }
  }
}
