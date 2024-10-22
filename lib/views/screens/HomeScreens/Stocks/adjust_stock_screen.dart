import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_text_field.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Stocks/controller/stock_controller.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:intl/intl.dart';

import '../../../../utils/app_strings.dart';


class AdjustStockScreen extends GetView<StockController> {
  const AdjustStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Adjust',
        centerTitle: false,
        isFullBody: false,
        actions: [
          GestureDetector(
            onTap: () async {
              // var result = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SimpleBarcodeScannerPage(),
              //   ),
              // );
              // if (result != null) {
              //   // Handle the barcode result here
              //   print('Barcode result: $result');
              // }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Image.asset(
                kBarCodeIcon,
              ),
            ),
          ),
        ],
        showAppBarBackButton: false,
        isCloseBackIcon: true,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeyStock,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Adjust',
                style: AppStyles.stockTextStyle().copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: kStock4TextColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 390.w,
                height: 2.h,
                decoration: const BoxDecoration(color: kStock4TextColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: 125.w,
                    height: 31.h,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: ShapeDecoration(
                      color: kLightGreyColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Obx(
                      ()=> Text(
                        controller.adjustDate.value,
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Obx(
                ()=> controller.isStockInLocation.isTrue ? CustomTextField(
                  controller: controller.adjuststocklocation,
                  hinttext: 'Select',
                  labeltext: 'Location:',
                  readOnly: true,
                  suffixIcon: GestureDetector(
                    onTap: (){
                      _showLocationModal(context);
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: kStock4TextColor,
                    ),
                  ),
                  color: kStock4TextColor,
                ): Container(),
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomTextField(
                readOnly: true,
                controller: controller.adjuststockitem,
                hinttext: 'Select Location first',
                labeltext: 'Item:',
                suffixIcon: GestureDetector(
                  onTap: (){
                    _showItemModal(context);
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: kStock4TextColor,
                  ),
                ),
                color: kStock4TextColor,
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomTextField(
                controller: controller.adjuststockdescription,
                hinttext: 'Type Here',
                
                labeltext: 'Description:',
                suffixIcon: const Icon(
                  Icons.arrow_forward_ios,
                  color: kStock4TextColor,
                ),
                color: kStock4TextColor,
              ),
              SizedBox(
                height: 240.h,
              ),
              Center(
                child: CustomButton(
                  width: 390.w,
                  height: 58.h,
                  color: kGreenButtonColor,
                  borderRadius: 10.r,
                  text: 'Submit',
                  textStyle: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  onPressed: () {
                    _showAddQuantityModal(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: kGreenButtonColor,
          hintColor: kGreenButtonColor,
          colorScheme: const ColorScheme.light(primary: kGreenButtonColor),
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    final DateFormat formatter = DateFormat('MMM d, yyyy');
    final String formatted = formatter.format(picked);
    controller.adjustDate.value = formatted;
    print("Selected date: $formatted");
    
  }
}
  void _showAddQuantityModal(BuildContext context) {
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Quantity',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                controller.adjuststockitem.text,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: kPrimaryColor),
                    onPressed: () {
                      int currentQuantity = int.parse(controller.quantityAdjustStock.text);
                      if (currentQuantity > 0) {
                        controller.quantityAdjustStock.text = (currentQuantity - 1).toString();
                      }
                    },
                  ),
                  SizedBox(
                    width: 60.0,
                    child: TextField(
                      controller: controller.quantityAdjustStock,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: kPrimaryColor),
                    onPressed: () {
                      int currentQuantity = int.parse(controller.quantityAdjustStock.text);
                      controller.quantityAdjustStock.text = (currentQuantity + 1).toString();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel', style: TextStyle(fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        if (controller.isStockInLocation.isTrue) {
                            if (controller.adjuststockitem.text == '' ||
                                controller.adjuststocklocation.text == ''
                                ) {
                              Get.snackbar("Error",
                                  'Please enter all the required data');
                            } else {
                              controller.addStockRequest(
                                  date: controller.adjustDate.value,
                                  itemId: controller.adjuststockitemId.text,
                                  itemName: controller.adjuststockitem.text,
                                  quantity: int.parse(controller
                                      .quantityAdjustStock.text),
                                  location: controller.adjuststocklocation.text,
                                  type: 'Adjust',
                                  note: controller.adjuststockdescription.text);
                                  Get.close(2);
                            }
                          } else {
                             if (controller.adjuststockitem.text == '') {
                              Get.snackbar("Error",
                                  'Please enter all the required data');
                            } else {
                              controller.addStockRequest(
                                  date: controller.adjustDate.value,
                                  itemId: controller.adjuststockitemId.text,
                                  itemName: controller.adjuststockitem.text,
                                  quantity: int.parse(controller
                                      .quantityAdjustStock.text),
                                  type: 'Adjust',
                                  note: controller.adjuststockdescription.text);
                                  Get.close(2);
                            }
                          }
                      },
                      child: const Text('OK', style: TextStyle(fontSize: 16.0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
void _showLocationModal(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Select Location'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...controller.locations.map((location) => ListTile(
                    title: Text(location),
                    onTap: () {
                      controller.adjuststocklocation.text = location;
                      Get.back();
                    },
                  )),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add New Location'),
                onTap: () {
                  _showAddLocationModal(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddLocationModal(BuildContext context) {
    TextEditingController locationController = TextEditingController();
    FocusNode locationFocusNode = FocusNode();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Add New Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: locationController,
              focusNode: locationFocusNode,
              decoration: InputDecoration(
                labelText: 'Location Name',
                labelStyle: TextStyle(
                  color:
                      locationFocusNode.hasFocus ? kPrimaryColor : Colors.grey,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              style: const TextStyle(color: kBlackTextColor),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: kWhiteButtonColor,
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              onPressed: () {
                controller.addLocation(locationController.text);
                Get.back();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemModal(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Select Item'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...controller.items.map((item) => ListTile(
                    title: Text(item['name'] ?? ''),
                    onTap: () {
                      controller.adjuststockitem.text = item['name'] ?? '';
                      controller.adjuststockitemId.text = item['id'] ?? '';
                      Get.back();
                    },
                  )),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add New Item'),
                onTap: () {
                  Get.toNamed(kRegisterNewItemsRoute);
                  controller.fetchItems();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
