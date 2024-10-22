import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/models/customers_model.dart';
import 'package:pro_cash_food/models/suppliers_model.dart';
import 'package:pro_cash_food/models/transfer_request.dart';

import '../../../../../models/stock_request.dart';
import '../../../TransferScreens/controller/transfer_screen_controller.dart';

class StockController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyStock = GlobalKey<ScaffoldState>();
  RxList<String> locations = <String>[].obs;
  RxList<String> suppliers = <String>[].obs;
  RxList<String> customers = <String>[].obs;
  RxList<Map<String, String>> items = <Map<String, String>>[].obs;
  RxBool isStockInLocation = true.obs;
  final String teamId = GetStorage().read('teamId') ?? '';
  final _storage= GetStorage();
  TransferScreenController controller = Get.put(TransferScreenController()); 

  // StockOut Controllers
  TextEditingController stockoutlocation = TextEditingController();
  TextEditingController stockoutcustomer = TextEditingController();
  TextEditingController stockoutitem = TextEditingController();
  TextEditingController stockoutitemId = TextEditingController();
  TextEditingController stockoutdescription = TextEditingController();
  TextEditingController quantityStockOutController = TextEditingController();
  RxString outDate = ''.obs;

  // StockIn Controllers
  TextEditingController stockinlocation = TextEditingController();
  TextEditingController stockinsupplier = TextEditingController();
  TextEditingController stockinitem = TextEditingController();
  TextEditingController stockinitemId = TextEditingController();
  TextEditingController stockindescription = TextEditingController();
  TextEditingController quantityStockInController = TextEditingController();
  RxString stockInDate = ''.obs;

  // MoveStock Controllers
  TextEditingController movestockfrom = TextEditingController();
  TextEditingController movestockto = TextEditingController();
  TextEditingController movestockitem = TextEditingController();
  TextEditingController movestockitemId = TextEditingController();
  TextEditingController movestockdescription = TextEditingController();
  TextEditingController quantityMoveStock = TextEditingController();
  RxString moveDate = ''.obs;

  // AdjustStock Controllers
  TextEditingController adjuststocklocation = TextEditingController();
  TextEditingController adjuststockitem = TextEditingController();
  TextEditingController adjuststockitemId = TextEditingController();
  TextEditingController adjuststockdescription = TextEditingController();
  TextEditingController quantityAdjustStock = TextEditingController();
  RxString adjustDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    String currentDate = DateFormat('MMM d, yyyy').format(DateTime.now());
    outDate.value = currentDate;
    stockInDate.value = currentDate;
    moveDate.value = currentDate;
    adjustDate.value = currentDate;
    fetchLocations();
    fetchSuppliers();
    fetchCustomers();
    fetchItems();
    checkingLocation();
  }

  void fetchLocations() async {
    try {
      DocumentSnapshot teamDoc = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .get();

      if (teamDoc.exists) {
        List<dynamic> locationsList = teamDoc['locations'] ?? [];
        locations.value =
            locationsList.map((location) => location.toString()).toList();
      } else {
        print('Team document does not exist.');
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  void fetchSuppliers() async {
    try {
      DocumentSnapshot teamDoc = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .get();

      if (teamDoc.exists) {
        List<dynamic> supplierList = teamDoc['suppliers'] ?? [];
        suppliers.value =
            supplierList.map((supplier) => supplier.toString()).toList();
      } else {
        print('Team document does not exist.');
      }
    } catch (e) {
      print('Error fetching suppliers: $e');
    }
  }

  void fetchCustomers() async {
    try {
      DocumentSnapshot teamDoc = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .get();

      if (teamDoc.exists) {
        List<dynamic> customerList = teamDoc['customers'] ?? [];
        customers.value =
            customerList.map((customer) => customer.toString()).toList();
      } else {
        print('Team document does not exist.');
      }
    } catch (e) {
      print('Error fetching customers: $e');
    }
  }

  void addLocation(String location) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'locations': FieldValue.arrayUnion([location]),
      });
      fetchLocations();
    } catch (e) {
      print('Error adding location: $e');
    }
  }

  void addSupplier(String supplier) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'suppliers': FieldValue.arrayUnion([supplier]),
      });
      final newItem = Supplier(
          name: supplier,
          teamId: GetStorage().read('teamId'),
          email: '',
          telephone: '',
          address: '',
          description: '');
      await FirebaseFirestore.instance
          .collection('suppliers')
          .add(newItem.toMap());
      fetchSuppliers();
    } catch (e) {
      print('Error adding location: $e');
    }
  }

  void addCustomer(String customer) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'customers': FieldValue.arrayUnion([customer]),
      });
      final newItem = Customer(
          name: customer,
          teamId: GetStorage().read('teamId'),
          email: '',
          telephone: '',
          address: '',
          description: '');
      await FirebaseFirestore.instance
          .collection('customers')
          .add(newItem.toMap());
      fetchCustomers();
    } catch (e) {
      print('Error adding customer: $e');
    }
  }

  void fetchItems() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('teamId', isEqualTo: teamId)
          .get();

      items.value = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'].toString(),
        };
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  void checkingLocation() async {
    try {
      DocumentSnapshot teamDoc = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .get();

      if (teamDoc.exists) {
        String mode = teamDoc['mode'] ?? '';
        isStockInLocation.value = (mode == 'Location Mode');
      } else {
        print('Team document does not exist.');
        isStockInLocation.value = false;
      }
    } catch (e) {
      print('Error checking location mode: $e');
      isStockInLocation.value = false;
    }
  }

  void addStockRequest({
    required String date,
    required String itemId,
    required String itemName,
    String? location,
    required int quantity,
    String? toLocation,
    String? supplier,
    String? note,
    String? customer,
    required String type,
  }) async {
    try {
      StockRequest newRequest = StockRequest(
        date: date,
        itemId: itemId,
        itemName: itemName,
        location: location,
        quantity: quantity,
        toLocation: toLocation,
        supplier: supplier,
        note: note,
        customer: customer,
        type: type,
        image: _storage.read('image'),
        userName: _storage.read('name'),
        stockedBy: _storage.read('id'),
        teamId: _storage.read('teamId')
      );
      await FirebaseFirestore.instance
          .collection('stock_requests')
          .add(newRequest.toMap());

      Get.snackbar(
        'Success',
        'Stock request added successfully!',
      );
      controller.fetchStockRequests();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add stock request: $e',
      );
    }
  }
}
