import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../models/stocks.dart';

class TransactionHistoryController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyTransaction = GlobalKey<ScaffoldState>();
  final selectedSortOption = 0.obs;
  var transactionRequests = <Stock>[].obs;
  var filteredTransactions = <Stock>[].obs;
  var groupedTransactions = <String, List<Stock>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactionHistory();
  }

  void fetchTransactionHistory() async {
    try {
      final stocksSnapshot = await FirebaseFirestore.instance
          .collection('stocks').where('teamId', isEqualTo: GetStorage().read('teamId'))
          .get();

      final List<Stock> fetchedTransactionRequests = stocksSnapshot.docs.map((doc) {
        final data = doc.data();
        return Stock.fromMap(data);
      }).toList();

      transactionRequests.value = fetchedTransactionRequests;
      filterTransactions();
    } catch (e) {
      print('Error fetching transaction history: $e');
    }
  }

  void filterTransactions() {
    filteredTransactions.value = transactionRequests.where((transaction) {
      switch (selectedSortOption.value) {
        case 0: return true;
        case 1: return transaction.type == 'Stock In';
        case 2: return transaction.type == 'Stock Out';
        case 3: return transaction.type == 'Adjust';
        case 4: return transaction.type == 'Move';
        default: return true;
      }
    }).toList();
    groupTransactionsByDate();
  }

  void groupTransactionsByDate() {
    final Map<String, List<Stock>> grouped = {};
    for (var transaction in filteredTransactions) {
      final date = transaction.date; 
      if (grouped[date] == null) {
        grouped[date] = [];
      }
      grouped[date]!.add(transaction);
    }
    groupedTransactions.value = grouped;
  }
}
