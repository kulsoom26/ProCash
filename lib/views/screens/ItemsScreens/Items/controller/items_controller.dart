
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../models/items_model.dart';

class ItemsController extends GetxController {
  var items = <Item>[].obs;
  var isLoading = true.obs;
    final GetStorage _storage = GetStorage();
    final selectedSortOption = 0.obs;
    final selectedFilterOption = 0.obs;
  TextEditingController searchQuery = TextEditingController();
  var search = ''.obs;
  var isItemLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    search = ''.obs;
    fetchItems();
  }

  void fetchItems() async {
    isLoading.value = true;
    print(_storage.read('teamId'));
    try {
      final teamId = _storage.read('teamId');
      final snapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('teamId', isEqualTo: teamId)
          .get();
      items.value = snapshot.docs
          .map((doc) => Item.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    
    } catch (e) {
      print('Error fetching items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void sortItems() {
    switch (selectedSortOption.value) {
      case 0: 
        items.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 1: 
        items.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 2: 
        items.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 3: 
        items.sort((a, b) => a.price.compareTo(b.price));
        break;
    }
  }
}
