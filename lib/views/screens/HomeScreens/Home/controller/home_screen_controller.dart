import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyHome = GlobalKey<ScaffoldState>();
  var date = ''.obs;
  var isToday = true.obs;
  var mode = ''.obs;
  TextEditingController count = TextEditingController();
  RxList<String> barcodes = <String>[].obs;

  // Rx variables to store stock summaries
  var totalStockInToday = 0.obs;
  var totalStockInYesterday = 0.obs;
  var totalStockOutToday = 0.obs;
  var totalStockOutYesterday = 0.obs;
  var totalQuantityInLocations = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTeamAndMode();
    updateDate();
    fetchBarcodes();
    fetchStockSummary();
  }

  void updateDate() {
    DateTime now = DateTime.now();
    DateTime dateToShow = isToday.value ? now : now.subtract(Duration(days: 1));
    date.value = DateFormat('MMM dd').format(dateToShow);
  }

  void toggleDate() {
    isToday.value = !isToday.value;
    updateDate();
  }

  Future<void> fetchTeamAndMode() async {
    try {
      if (GetStorage().read('mode') == 'Location Mode') {
        mode.value = 'Location Mode';
      } else {
        mode.value = 'Basic Mode';
      }
    } catch (e) {
      print('Error fetching team and mode: $e');
    }
  }

  void fetchBarcodes() async {
    try {
      String? teamId = GetStorage().read('teamId');
      if (teamId == null || teamId.isEmpty) {
        Get.snackbar("Error", "Team ID not found");
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final QuerySnapshot snapshot = await firestore
          .collection('items')
          .where('teamId', isEqualTo: teamId)
          .get();

      barcodes.clear();
      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          String? barcode = data['barcode'] as String?;
          if (barcode != null) {
            barcodes.add(barcode);
          }
        }
      }
    } catch (e) {
      print("Error fetching barcodes: $e");
    }
  }

  Future<void> fetchStockSummary() async {
    try {
      String? teamId = GetStorage().read('teamId');
      if (teamId == null || teamId.isEmpty) {
        Get.snackbar("Error", "Team ID not found");
        return;
      }

      DateTime now = DateTime.now();
      String today = DateFormat('MMM d, yyyy').format(now);
      String yesterday =
          DateFormat('MMM d, yyyy').format(now.subtract(Duration(days: 1)));
      print(today);
      print(yesterday);

      totalStockInToday.value =
          await _fetchStockQuantity(teamId, today, 'Stock In');
      totalStockInYesterday.value =
          await _fetchStockQuantity(teamId, yesterday, 'Stock In');

      totalStockOutToday.value =
          await _fetchStockQuantity(teamId, today, 'Stock Out');
      totalStockOutYesterday.value =
          await _fetchStockQuantity(teamId, yesterday, 'Stock Out');

      print('Total Stock In (Today): ${totalStockInToday.value}');
      print('Total Stock In (Yesterday): ${totalStockInYesterday.value}');
      print('Total Stock Out (Today): ${totalStockOutToday.value}');
      print('Total Stock Out (Yesterday): ${totalStockOutYesterday.value}');

      totalQuantityInLocations.value =
          await _fetchTotalQuantityInLocations(teamId);
      print(
          'Total quantity in all locations: ${totalQuantityInLocations.value}');
    } catch (e) {
      print("Error fetching stock summary: $e");
    }
  }

  Future<int> _fetchStockQuantity(
      String teamId, String date, String type) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('stocks')
          .where('teamId', isEqualTo: teamId)
          .where('date', isEqualTo: date)
          .where('type', isEqualTo: type)
          .get();

      var totalQuantity = 0;
      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          totalQuantity += (data['quantity'] as num?)?.toInt() ?? 0;
        }
      }
      return totalQuantity;
    } catch (e) {
      print("Error fetching stock quantity for $type on $date: $e");
      return 0;
    }
  }

  Future<int> _fetchTotalQuantityInLocations(String teamId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('teamId', isEqualTo: teamId)
          .get();

      int totalQuantity = 0;
      if (GetStorage().read('mode') == 'Location Mode') {
        for (var doc in snapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          if (data != null && data['locations'] != null) {
            List<dynamic> locations = data['locations'] as List<dynamic>;
            for (var location in locations) {
              totalQuantity += (location['quantity'] as num?)?.toInt() ?? 0;
            }
          }
        }
        return totalQuantity;
      } else {
        for (var doc in snapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          if (data != null) {
            totalQuantity += (data['quantity'] as num?)?.toInt() ?? 0;
          }
        }
        return totalQuantity;
      }
    } catch (e) {
      print("Error fetching total quantity in locations: $e");
      return 0;
    }
  }
}
