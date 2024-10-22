import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyAdminHome = GlobalKey<ScaffoldState>();
  RxInt requestNo = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequestCount();
  }

  Future<void> fetchRequestCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .get();

      requestNo.value = querySnapshot.docs.length;
    } catch (e) {
      print("Error fetching request count: $e");
    }
  }
}
