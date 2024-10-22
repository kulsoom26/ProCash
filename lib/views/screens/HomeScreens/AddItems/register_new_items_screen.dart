import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_text_field.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/AddItems/controller/register_new_items_controller.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../../../models/attributes_model.dart';
import '../../../custom_widgets/custom_button.dart';

class RegisterNewItemsScreen extends GetView<RegisterNewItemController> {
  const RegisterNewItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterNewItemController());

    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Add Item',
        centerTitle: false,
        isFullBody: false,
        showAppBarBackButton: false,
        isCloseBackIcon: true,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeyRegisterNewItem,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomProfileImagePicker(),
              Obx(() => ToggleSwitch(
                    initialLabelIndex: controller.toggleIndex.value,
                    totalSwitches: 2,
                    labels: const ['Basic Details', 'Item Attribute Access'],
                    activeBgColor: const [kGreenButtonColor],
                    onToggle: (index) {
                      controller.toggleIndex.value = index!;
                    },
                    minWidth: 370.w,
                    minHeight: 50.h,
                    radiusStyle: true,
                    cornerRadius: 8.r,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: kGreenButtonColor,
                    fontSize: 14.sp,
                  )),
              SizedBox(
                height: 40.h,
              ),
              Obx(() {
                if (controller.toggleIndex.value == 0) {
                  return Column(
                    children: [
                      CustomTextField(
                        controller: controller.itemname,
                        hinttext: 'Add Item Name',
                        labeltext: 'Item Name:',
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kGreenButtonColor,
                        ),
                        color: kGreenButtonColor,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomTextField(
                        controller: controller.barcode,
                        hinttext: 'Select Barcode Input Method',
                        labeltext: 'Barcode:',
                        readOnly: true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _showBarcodeInputMethod(context);
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: kGreenButtonColor,
                          ),
                        ),
                        color: kGreenButtonColor,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomTextField(
                        controller: controller.cost,
                        hinttext: 'Add Cost',
                        labeltext: 'Cost:',
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kGreenButtonColor,
                        ),
                        color: kGreenButtonColor,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomTextField(
                        controller: controller.price,
                        hinttext: 'Add Price',
                        labeltext: 'Price:',
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kGreenButtonColor,
                        ),
                        color: kGreenButtonColor,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomTextField(
                        controller: controller.quantity,
                        hinttext: 'Add Quantity',
                        labeltext: 'Quantity:',
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kGreenButtonColor,
                        ),
                        color: kGreenButtonColor,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Obx(
                          () => controller.isLoading.isTrue
                              ? CircularProgressIndicator(
                                  color: kGreenButtonColor,
                                )
                              : CustomButton(
                                  width: 390.w,
                                  height: 58.h,
                                  color: kGreenButtonColor,
                                  borderRadius: 10.r,
                                  text: 'Add Item',
                                  textStyle:
                                      AppStyles.whiteTextStyle().copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  onPressed: () {
                                    if (controller.itemname.text == '' ||
                                        controller.barcode.text == '' ||
                                        controller.cost.text == '' ||
                                        controller.price.text == '' ||
                                        controller.quantity.text == '' ||
                                        !controller
                                            .areAllAttributeFieldsFilled()) {
                                      Get.snackbar('Error',
                                          'Please enter all the fields');
                                    } else {
                                      controller.isLoading.value = true;
                                      controller.addItemToFirestore();
                                      Get.back();
                                    }
                                  },
                                ),
                        ),
                      ),
                      SizedBox(height: 20.h,)
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ...controller.teamAttributes.asMap().entries.map((entry) {
                        int index = entry.key;
                        Attribute attribute = entry.value;
                        return Column(
                          children: [
                            Obx(
                              () => CustomTextField(
                                controller: controller.attributeControllers[index],
                                hinttext: 'Add ${attribute.name}',
                                labeltext: '${attribute.name}:',
                                suffixIcon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: kGreenButtonColor,
                                ),
                                color: kGreenButtonColor,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                          ],
                        );
                      }).toList(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showAddAttributeDialog(context, controller);
                              },
                              child: Container(
                                width: 50.w,
                                height: 40.h,
                                decoration: ShapeDecoration(
                                  color: kLightGreenContainerColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r)),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: kGreenButtonColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            Text(
                              'Edit Attribute',
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

 void _showAddAttributeDialog(
    BuildContext context, RegisterNewItemController controller) {
  final attributeOptions = [
    'Type',
    'Brand',
    'Color',
    'Manufacturer',
    'Storage',
    'Size',
    'Note',
    'Lot Number'
  ];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Attributes'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: 300.w,
              height: 400.h,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: attributeOptions.length,
                      itemBuilder: (context, index) {
                        final attribute = attributeOptions[index];
                        return Obx(() {
                          final isSelected = controller.teamAttributes
                              .map((e) => e.name)
                              .contains(attribute);

                          return ListTile(
                            title: Text(attribute),
                            trailing: isSelected
                                ? IconButton(
                                    icon: Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        controller.removeAttribute(attribute);
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(Icons.add_circle,
                                        color: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        controller.addAttribute(Attribute(
                                            name: attribute, type: 'Text'));
                                      });
                                    },
                                  ),
                          );
                        });
                      },
                    ),
                  ),
                  TextButton(
                    child: Text('Done',
                        style: TextStyle(color: kGreenButtonColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}


  void _showRenameModal(
      BuildContext context, TextEditingController controller) {
    TextEditingController _renameController =
        TextEditingController(text: controller.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Input Barcode mannually',
                    style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15.h,
                ),
                Text('Input Barcode',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 15.sp,
                    )),
                SizedBox(height: 20.h),
                TextField(
                  controller: _renameController,
                  decoration: InputDecoration(
                    hintText: 'Input item barcode',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 20.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',
                            style: AppStyles.blackTextStyle()
                                .copyWith(fontSize: 18.sp)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 20.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controller.text = _renameController.text;
                          Navigator.pop(context);
                        },
                        child: Text('OK', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBarcodeInputMethod(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r)),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.h,
            ),
            Center(
                child: Text(
              'Barcode Input Method',
              style: AppStyles.blackTextStyle()
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
            )),
            SizedBox(
              height: 20.h,
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r)),
                child: ListTile(
                  leading: Image.asset(
                    kScanBarcode,
                    width: 35.w,
                  ),
                  title: Text('Scan with Camera'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SimpleBarcodeScannerPage(
                          result: controller.barcode, 
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r)),
                child: ListTile(
                  leading: Image.asset(
                    kInputBarcode,
                    width: 35.w,
                  ),
                  title: Text('Input Manually'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pop(context);
                    _showRenameModal(context, controller.barcode);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r)),
                child: ListTile(
                  leading: Image.asset(
                    kGenerateBarcode,
                    width: 35.w,
                  ),
                  title: Text('Generate Barcode'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    final barcode = controller.generateRandomBarcode();
                    controller.barcode.text = barcode;
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      );
    },
  );
}

}

class CustomProfileImagePicker extends StatefulWidget {
  const CustomProfileImagePicker({super.key});

  @override
  State<CustomProfileImagePicker> createState() =>
      _CustomProfileImagePickerState();
}

class _CustomProfileImagePickerState extends State<CustomProfileImagePicker> {
  RegisterNewItemController controller = Get.put(RegisterNewItemController());

  Future<void> _getImageFromCameraOrGallery(BuildContext context) async {
    await showModalBottomSheet<File?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          textAlign: TextAlign.center,
                          'Camera',
                          style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          await controller.getImageCamera();
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Text(
                          textAlign: TextAlign.center,
                          'Gallery',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          await controller.getImageGallery();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',
                        style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => controller.isUploading.isTrue
            ? CircularProgressIndicator(
                color: kPrimaryColor,
              )
            : controller.imagePath.value.isEmpty
                ? Center(
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 150.w,
                          height: 150.h,
                          child: Image.asset(
                            kTeamProfile,
                          ),
                        ),
                        Positioned(
                          right: 45,
                          bottom: 50,
                          child: GestureDetector(
                            onTap: () async {
                              _getImageFromCameraOrGallery(context);
                            },
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: ShapeDecoration(
                                color: kGreyButtonColor,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    width: 2.w,
                                    color: kWhiteTextColor,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: kWhiteTextColor,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      controller.imagePath.value))),
                        ),
                        Positioned(
                          right: 45,
                          bottom: 50,
                          child: GestureDetector(
                            onTap: () async {
                              _getImageFromCameraOrGallery(context);
                            },
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: ShapeDecoration(
                                color: kGreyButtonColor,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    width: 2.w,
                                    color: kWhiteTextColor,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: kWhiteTextColor,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
