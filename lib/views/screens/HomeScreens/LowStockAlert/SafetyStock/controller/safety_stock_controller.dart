import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../../models/items_model.dart';

class SafetyStockController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeySafetyStock = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeySafetyAlert = GlobalKey<ScaffoldState>();

  RxList<Item> items = <Item>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String teamId = storage.read('teamId') ?? '';

      firestore.collection('items').where('teamId', isEqualTo: teamId).snapshots().listen((snapshot) {
        items.clear();
        for (var doc in snapshot.docs) {
          items.add(Item.fromMap(doc.id, doc.data()));
        }
      });
    } catch (e) {
      print("Error fetching items: $e");
    }
  }

  bool isLowStock(Item item) {
    String mode = storage.read('mode') ?? 'Basic Mode';
    if (mode == 'Location Mode') {
      if (item.locations == null || item.locations!.isEmpty) {
        return item.quantity <= 10;
      }
      return item.locations!.any((location) => location['quantity'] <= 10);
    } else {
      return item.quantity <= 10;
    }
  }

  int getLocationQuantity(Item item) {
    String mode = storage.read('mode') ?? 'Basic Mode';
    if (mode == 'Location Mode') {
      if (item.locations != null && item.locations!.isNotEmpty) {
        return item.locations!
            .map((location) => location['quantity'] ?? 0)
            .reduce((a, b) => a + b);
      }
    }
    return item.quantity;
  }
}
