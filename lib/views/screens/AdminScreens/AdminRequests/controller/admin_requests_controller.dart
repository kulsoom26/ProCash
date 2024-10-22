import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/models/request_model.dart';
import 'package:pro_cash_food/models/user_model.dart';
import 'package:pro_cash_food/views/screens/AdminScreens/AdminHome/controller/admin_home_controller.dart';

class AdminRequestController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyAdminRequest = GlobalKey<ScaffoldState>();
  RxList<Request> requests = <Request>[].obs;
  RxBool isLoading = true.obs;
  AdminHomeController cont = Get.put(AdminHomeController());
  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .get();

      requests.value = querySnapshot.docs.map((doc) {
        return Request.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
      cont.requestNo.value = requests.length;
    } catch (e) {
      print("Error fetching requests: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptRequest(Request request) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(request.id)
          .set(request.toMap());

      await FirebaseFirestore.instance
          .collection('requests')
          .doc(request.id)
          .delete();

      requests.remove(request);
      Get.snackbar('Success', 'Request accepted and user added.');
      cont.requestNo.value = requests.length;
    } catch (e) {
      print("Error accepting request: $e");
      Get.snackbar('Error', 'Failed to accept request.');
    }
  }

  Future<void> rejectRequest(Request request) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(request.id)
          .delete();

      requests.remove(request);
      Get.snackbar('Success', 'Request rejected.');
      cont.requestNo.value = requests.length;
    } catch (e) {
      print("Error rejecting request: $e");
      Get.snackbar('Error', 'Failed to reject request.');
    }
  }
}
