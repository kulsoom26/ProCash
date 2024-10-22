import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/models/items_model.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Items/controller/items_controller.dart';

class EditItemsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyEditItem = GlobalKey<ScaffoldState>();
  final switchController = ValueNotifier<bool>(false);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ItemsController controller = Get.put(ItemsController());

  Future<void> copyItemToFirestore(Item item) async {
    try {
      final newItem = Item(
        teamId: item.teamId,
        name: item.name,
        barcode: item.barcode,
        cost: item.cost,
        price: item.price,
        image: item.image,
        quantity: item.quantity,
        attributes: item.attributes,
        locations: item.locations,
      );

      await _firestore.collection('items').add(newItem.toMap());
      controller.fetchItems();
      Get.snackbar('Success', '${item.name} has been successfully copied into items!!');
    } catch (e) {
      Get.snackbar('Error', '${item.name} failed to be added in the items!!');
    }
  }

  Future<void> deleteItemFromFirestore(Item item) async {
    try {
      final querySnapshot = await _firestore
          .collection('items')
          .where('name', isEqualTo: item.name)
          .where('barcode', isEqualTo: item.barcode)
          .get();

      if (querySnapshot.docs.isEmpty) {
        Get.snackbar('Error', 'Item not found!');
        return;
      }
      final documentId = querySnapshot.docs.first.id;

      await _firestore.collection('items').doc(documentId).delete();
      controller.fetchItems();
      Get.snackbar('Success', '${item.name} has been successfully deleted from items!!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete ${item.name} from items!!');
    }
  }

  Future<void> updateItem(String barcode, Item updatedItem) async {
  try {
    final querySnapshot = await _firestore
        .collection('items')
        .where('barcode', isEqualTo: barcode)
        .get();

    if (querySnapshot.docs.isEmpty) {
      Get.snackbar('Error', 'Item not found!');
      return;
    }
    final documentId = querySnapshot.docs.first.id;

    await _firestore.collection('items').doc(documentId).update(updatedItem.toMap());
    Get.snackbar(
      'Success',
      'Item updated successfully',
    );
    controller.fetchItems();
    Get.close(2);
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to update item: $e',
    );
  }
}

}
