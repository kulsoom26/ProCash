import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Home/controller/home_screen_controller.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/screens/shared.dart';


class CustomisedSimpleBarcodeScannerPage extends StatelessWidget {
  final String lineColor;
  final String cancelButtonText;
  final bool isShowFlashIcon;
  final ScanType scanType;
  final String? appBarTitle;
  final TextEditingController result;
  final bool? centerTitle;

  CustomisedSimpleBarcodeScannerPage({
    super.key,
    this.lineColor = "#ff6666",
    this.cancelButtonText = "Cancel",
    this.isShowFlashIcon = false,
    this.scanType = ScanType.barcode,
    this.appBarTitle,
    this.centerTitle,
    required this.result,
  });

  final HomeController barcodeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return BarcodeScanner(
      lineColor: lineColor,
      cancelButtonText: cancelButtonText,
      isShowFlashIcon: isShowFlashIcon,
      scanType: scanType,
      appBarTitle: appBarTitle,
      centerTitle: centerTitle,
      onScanned: (res) {
        result.text = res;
        bool found = barcodeController.barcodes.contains(res);
        if (found) {
          Get.snackbar(
            "Item Found",
            "Barcode: $res\nCount: ${barcodeController.barcodes.length}",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Item Not Found",
            "Barcode: $res",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
        Navigator.pop(context, res);
      },
    );
  }
}
