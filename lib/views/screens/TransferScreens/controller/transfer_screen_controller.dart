import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/models/stock_request.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Home/controller/home_screen_controller.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Items/controller/items_controller.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/Transactions/controller/transaction_history_controller.dart';
import '../../../../models/items_model.dart';
import '../../../../models/stocks.dart';

class TransferScreenController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyTransfer = GlobalKey<ScaffoldState>();
  ItemsController controller = Get.put(ItemsController());
  TransactionHistoryController controller1 =
      Get.put(TransactionHistoryController());
  HomeController controller2 = Get.put(HomeController());

  var selectedSort = 'All'.obs;
  final List<String> sortOptions = [
    'All',
    'Stock In',
    'Stock Out',
    'Adjust',
    'Move'
  ];

  var transferRequests = <StockRequest>[].obs;
  var filteredRequests = <StockRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStockRequests();
  }

  void fetchStockRequests() async {
    try {
      final userId = GetStorage().read('id');
      final teamsSnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('adminId', isEqualTo: userId)
          .get();

      if (teamsSnapshot.docs.isNotEmpty && GetStorage().read('id') == GetStorage().read('adminId')) {
        final stockRequestsSnapshot =
            await FirebaseFirestore.instance.collection('stock_requests').get();

        final stockRequests = stockRequestsSnapshot.docs.map((doc) {
          final data = doc.data();
          return StockRequest.fromMap(data);
        }).toList();

        final List<StockRequest> fetchedTransferRequests =
            stockRequests.map((stockRequest) {
          return StockRequest(
              date: stockRequest.date,
              itemId: stockRequest.itemId,
              itemName: stockRequest.itemName,
              location: stockRequest.location,
              quantity: stockRequest.quantity,
              toLocation: stockRequest.toLocation,
              supplier: stockRequest.supplier,
              note: stockRequest.note,
              customer: stockRequest.customer,
              type: stockRequest.type,
              image: stockRequest.image,
              userName: stockRequest.userName,
              stockedBy: stockRequest.stockedBy,
              teamId: stockRequest.teamId);
        }).toList();

        transferRequests.value = fetchedTransferRequests;
        filteredRequests.value = transferRequests;
        filteredRequests();
        print(transferRequests.length);
      }
    } catch (e) {
      print('Error fetching stock requests: $e');
    }
  }

  void filterRequests() {
    if (selectedSort.value == 'All') {
      filteredRequests.value = transferRequests;
      print(filteredRequests.length);
    } else {
      filteredRequests.value = transferRequests
          .where((request) => request.type == selectedSort.value)
          .toList();
      print(filteredRequests.length);
    }
  }

  void rejectRequest(StockRequest request) async {
    try {
      final stockRequestsSnapshot = await FirebaseFirestore.instance
          .collection('stock_requests')
          .where('itemId', isEqualTo: request.itemId)
          .where('type', isEqualTo: request.type)
          .where('itemName', isEqualTo: request.itemName)
          .where('userName', isEqualTo: request.userName)
          .get();

      if (stockRequestsSnapshot.docs.isNotEmpty) {
        for (var doc in stockRequestsSnapshot.docs) {
          await FirebaseFirestore.instance
              .collection('stock_requests')
              .doc(doc.id)
              .delete();
        }
        Get.snackbar(
            'Request Deleted', 'Your request has been deleted successfully!');
        transferRequests.remove(request);
        filteredRequests.remove(request);
      }
    } catch (e) {
      print('Error rejecting request: $e');
    }
  }

  void acceptRequest(StockRequest request) async {
    try {
      final itemDoc = await FirebaseFirestore.instance
          .collection('items')
          .doc(request.itemId)
          .get();

      if (itemDoc.exists) {
        final item = Item.fromMap(itemDoc.id, itemDoc.data()!);
        String mode = GetStorage().read('mode') ?? 'Basic Mode';
        int updatedQuantity = item.quantity + request.quantity;
        List<Map<String, dynamic>> updatedLocations =
            (item.locations ?? []).toList();

        if (mode == 'Location Mode') {
          if (request.type == 'Stock In') {
            bool locationExists = false;
            for (var location in updatedLocations) {
              if (location['name'] == request.location) {
                location['quantity'] =
                    (location['quantity'] ?? 0) + request.quantity;
                locationExists = true;
                break;
              }
            }
            if (!locationExists) {
              updatedLocations.add({
                'name': request.location!,
                'quantity': request.quantity,
              });
            }
          }
          await FirebaseFirestore.instance
              .collection('items')
              .doc(item.id)
              .update({
            'quantity': updatedQuantity,
            'locations': updatedLocations
                .map((loc) => {
                      'name': loc['name'],
                      'quantity': loc['quantity'],
                    })
                .toList(),
          });
        } else if (mode == 'Basic Mode') {
          await FirebaseFirestore.instance
              .collection('items')
              .doc(item.id)
              .update({
            'quantity': updatedQuantity,
          });
        }

        await _addNewStockEntry(request);
        await _removeStockRequests(request);

        Get.snackbar(
            'Request Accepted', 'The request has been accepted successfully!');
      }
    } catch (e) {
      print('Error accepting request: $e');
    }
  }

  void acceptStockOutRequest(StockRequest request) async {
    try {
      final itemDoc = await FirebaseFirestore.instance
          .collection('items')
          .doc(request.itemId)
          .get();

      if (itemDoc.exists) {
        final item = Item.fromMap(itemDoc.id, itemDoc.data()!);
        String mode = GetStorage().read('mode') ?? 'Basic Mode';
        int currentQuantity = item.quantity;
        List<Map<String, dynamic>> updatedLocations =
            (item.locations ?? []).toList();

        if (mode == 'Location Mode') {
          bool locationExists = false;
          for (var location in updatedLocations) {
            if (location['name'] == request.location) {
              locationExists = true;
              if (location['quantity'] >= request.quantity) {
                location['quantity'] -= request.quantity;
                currentQuantity -= request.quantity;

                await FirebaseFirestore.instance
                    .collection('items')
                    .doc(item.id)
                    .update({
                  'quantity': currentQuantity,
                  'locations': updatedLocations
                      .map((loc) => {
                            'name': loc['name'],
                            'quantity': loc['quantity'],
                          })
                      .toList(),
                });

                await _addNewStockEntry(request);
                await _removeStockRequests(request);

                Get.snackbar('Request Accepted',
                    'The request has been accepted successfully!');
              } else {
                Get.snackbar('Insufficient Quantity',
                    'Not enough items to be stocked out.');
              }
              break;
            }
          }

          if (!locationExists) {
            Get.snackbar('Location Not Found',
                'Item not stocked in the requested location.');
          }
        } else if (mode == 'Basic Mode') {
          if (currentQuantity >= request.quantity) {
            currentQuantity -= request.quantity;

            await FirebaseFirestore.instance
                .collection('items')
                .doc(item.id)
                .update({
              'quantity': currentQuantity,
            });

            await _addNewStockEntry(request);
            await _removeStockRequests(request);

            Get.snackbar('Request Accepted',
                'The request has been accepted successfully!');
          } else {
            Get.snackbar(
                'Insufficient Quantity', 'Not enough items to be stocked out.');
          }
        }
      }
    } catch (e) {
      print('Error accepting stock out request: $e');
    }
  }

  Future<void> _addNewStockEntry(StockRequest request) async {
    final newStock = Stock(
        date: request.date,
        itemId: request.itemId,
        itemName: request.itemName,
        location: request.location,
        quantity: request.quantity,
        toLocation: request.toLocation,
        supplier: request.supplier,
        note: request.note,
        customer: request.customer,
        type: request.type,
        image: request.image,
        userName: request.userName,
        stockedBy: request.stockedBy,
        teamId: GetStorage().read('teamId'));

    await FirebaseFirestore.instance.collection('stocks').add(newStock.toMap());
  }

  Future<void> _removeStockRequests(StockRequest request) async {
    final stockRequestsSnapshot = await FirebaseFirestore.instance
        .collection('stock_requests')
        .where('itemId', isEqualTo: request.itemId)
        .where('type', isEqualTo: request.type)
        .where('itemName', isEqualTo: request.itemName)
        .where('userName', isEqualTo: request.userName)
        .get();

    if (stockRequestsSnapshot.docs.isNotEmpty) {
      for (var doc in stockRequestsSnapshot.docs) {
        await FirebaseFirestore.instance
            .collection('stock_requests')
            .doc(doc.id)
            .delete();
      }
      transferRequests.remove(request);
      filteredRequests.remove(request);
      controller.fetchItems();
      controller1.fetchTransactionHistory();
      controller2.fetchStockSummary();
    }
  }

  void adjustStock(StockRequest request) async {
  try {
    final itemDoc = await FirebaseFirestore.instance
        .collection('items')
        .doc(request.itemId)
        .get();

    if (itemDoc.exists) {
      final item = Item.fromMap(itemDoc.id, itemDoc.data()!);
      String mode = GetStorage().read('mode') ?? 'Basic Mode';
      List<Map<String, dynamic>> updatedLocations = (item.locations ?? []).toList();

      if (mode == 'Location Mode') {
        bool locationExists = false;
        int totalQuantity = 0;

        for (var location in updatedLocations) {
          if (location['name'] == request.location) {
            locationExists = true;
            location['quantity'] = request.quantity;
          }
          totalQuantity += (location['quantity'] as num).toInt();
        }

        if (!locationExists) {
          Get.snackbar('Location Not Found', 'Item not stocked in the requested location.');
          return;
        }

        await FirebaseFirestore.instance
            .collection('items')
            .doc(item.id)
            .update({
          'quantity': totalQuantity,
          'locations': updatedLocations
              .map((loc) => {
                    'name': loc['name'],
                    'quantity': loc['quantity'],
                  })
              .toList(),
        });

      } else if (mode == 'Basic Mode') {
        await FirebaseFirestore.instance
            .collection('items')
            .doc(item.id)
            .update({
          'quantity': request.quantity,
        });
      }

      final newStock = Stock(
          date: request.date,
          itemId: request.itemId,
          itemName: request.itemName,
          location: request.location,
          quantity: request.quantity,
          note: request.note,
          type: request.type,
          image: request.image,
          userName: request.userName,
          stockedBy: request.stockedBy,
          teamId: GetStorage().read('teamId'));

      await FirebaseFirestore.instance
          .collection('stocks')
          .add(newStock.toMap());

      final stockRequestsSnapshot = await FirebaseFirestore.instance
          .collection('stock_requests')
          .where('itemId', isEqualTo: request.itemId)
          .where('type', isEqualTo: request.type)
          .where('itemName', isEqualTo: request.itemName)
          .where('userName', isEqualTo: request.userName)
          .get();

      if (stockRequestsSnapshot.docs.isNotEmpty) {
        for (var doc in stockRequestsSnapshot.docs) {
          await FirebaseFirestore.instance
              .collection('stock_requests')
              .doc(doc.id)
              .delete();
        }
        transferRequests.remove(request);
        filteredRequests.remove(request);
        controller.fetchItems();
        controller1.fetchTransactionHistory();
        controller2.fetchStockSummary();
      }

      Get.snackbar('Stock Adjusted', 'The stock has been adjusted successfully!');
    }
  } catch (e) {
    print('Error adjusting stock: $e');
  }
}


  void moveStock(StockRequest request) async {
    try {
      final itemDoc = await FirebaseFirestore.instance
          .collection('items')
          .doc(request.itemId)
          .get();

      if (itemDoc.exists) {
        final item = Item.fromMap(itemDoc.id, itemDoc.data()!);
        List<Map<String, dynamic>> updatedLocations =
            (item.locations ?? []).toList();

        bool fromLocationExists = false;
        bool toLocationExists = false;

        int fromLocationQuantity = 0;

        for (var location in updatedLocations) {
          if (location['name'] == request.location) {
            fromLocationExists = true;
            fromLocationQuantity = location['quantity'];
            if (location['quantity'] >= request.quantity) {
              location['quantity'] -= request.quantity;
            } else {
              Get.snackbar('Insufficient Quantity',
                  'Not enough items to move from the requested location.');
              return;
            }
            break;
          }
        }

        if (!fromLocationExists) {
          Get.snackbar('Location Not Found',
              'Item not stocked in the requested from location.');
          return;
        }
        for (var location in updatedLocations) {
          if (location['name'] == request.toLocation) {
            toLocationExists = true;
            location['quantity'] += request.quantity;
            break;
          }
        }
        if (!toLocationExists) {
          updatedLocations.add({
            'name': request.toLocation!,
            'quantity': request.quantity,
          });
        }
        await FirebaseFirestore.instance
            .collection('items')
            .doc(item.id)
            .update({
          'locations': updatedLocations
              .map((loc) => {
                    'name': loc['name'],
                    'quantity': loc['quantity'],
                  })
              .toList(),
        });
        final newStock = Stock(
            date: request.date,
            itemId: request.itemId,
            itemName: request.itemName,
            location: request.location,
            quantity: request.quantity,
            toLocation: request.toLocation,
            supplier: request.supplier,
            note: request.note,
            customer: request.customer,
            type: request.type,
            image: request.image,
            userName: request.userName,
            stockedBy: request.stockedBy,
            teamId: GetStorage().read('teamId'));

        await FirebaseFirestore.instance
            .collection('stocks')
            .add(newStock.toMap());
        final stockRequestsSnapshot = await FirebaseFirestore.instance
            .collection('stock_requests')
            .where('itemId', isEqualTo: request.itemId)
            .where('type', isEqualTo: request.type)
            .where('itemName', isEqualTo: request.itemName)
            .where('userName', isEqualTo: request.userName)
            .get();

        if (stockRequestsSnapshot.docs.isNotEmpty) {
          for (var doc in stockRequestsSnapshot.docs) {
            await FirebaseFirestore.instance
                .collection('stock_requests')
                .doc(doc.id)
                .delete();
          }
          transferRequests.remove(request);
          filteredRequests.remove(request);
          controller.fetchItems();
          controller1.fetchTransactionHistory();
        }

        Get.snackbar('Stock Moved', 'The stock has been moved successfully!');
      }
    } catch (e) {
      print('Error moving stock: $e');
    }
  }
}
