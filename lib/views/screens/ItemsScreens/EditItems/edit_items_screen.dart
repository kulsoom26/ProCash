import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/EditItems/controller/edit_items_controller.dart';

import '../../../../models/items_model.dart';

class EditItemsScreen extends GetView<EditItemsController> {
  const EditItemsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Item item = Get.arguments;
    return SafeArea(
        child: CustomScaffold(
            className: runtimeType.toString(),
            screenName: item.name,
            centerTitle: false,
            isFullBody: false,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showUpdateModal(context, item.name, item);
                      },
                      child: Container(
                        width: 45.w,
                        height: 35.h,
                        decoration: ShapeDecoration(
                          color: kLightGreenContainerColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: const Icon(
                          Icons.edit_square,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showEditModal(context, item.name, item);
                      },
                      child: Container(
                        width: 45.w,
                        height: 35.h,
                        decoration: ShapeDecoration(
                          color: kLightGreenContainerColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: const Icon(
                          Icons.more_horiz,
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
            showAppBarBackButton: false,
            isCloseBackIcon: false,
            isBackIcon: true,
            scaffoldKey: controller.scaffoldKeyEditItem,
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: 390.w,
                    height: 297.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      shadows: [
                        BoxShadow(
                          color: kBoxShadowColor,
                          blurRadius: 10.r,
                          offset: const Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 30.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      width: 130.w,
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Image.network(item.image))
                                ],
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    item.name,
                                    style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.inventory_2,
                                                color: kPrimaryColor,
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                '${item.quantity}',
                                                style: AppStyles.greyTextStyle()
                                                    .copyWith(),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.local_offer,
                                                color: kPrimaryColor,
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 5.w),
                                              if (GetStorage()
                                                          .read('currency') !=
                                                      null)
                                                Text(
                                                  '${item.price} ${GetStorage().read('currency')}',
                                                  style:
                                                      AppStyles.greyTextStyle(),
                                                ),
                                              if (GetStorage()
                                                          .read('currency') ==
                                                      null )
                                                Text(
                                                  '${item.price}',
                                                  style:
                                                      AppStyles.greyTextStyle(),
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.qr_code,
                                                color: kPrimaryColor,
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                item.barcode,
                                                style: AppStyles.greyTextStyle()
                                                    .copyWith(),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: kPrimaryColor,
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                '${item.locations?.length ?? 0}',
                                                style: AppStyles.greyTextStyle()
                                                    .copyWith(),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              spacing: 5.w,
                              runSpacing: 5.h,
                              children: interleaveAttributesWithSeparator(
                                  item.attributes, "|"),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomButton(
                            width: 344.w,
                            height: 58.h,
                            color: const Color(0xFFF6F6F6),
                            borderRadius: 10.r,
                            suffixIcon: const Icon(Icons.arrow_forward_rounded),
                            text: 'View Past Transactions',
                            textStyle: AppStyles.blackTextStyle().copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Get.toNamed(kItemDetailsRoute, arguments: item);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.locations?.length ?? 0} Locations',
                        style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        'In Stock',
                        style: AppStyles.greyTextStyle().copyWith(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      AdvancedSwitch(
                        controller: controller.switchController,
                        activeColor: kGreenButtonColor,
                        inactiveColor: kGreyTextColor,
                        borderRadius: BorderRadius.circular(12.r),
                        width: 40.w,
                        height: 19.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (item.locations != null && item.locations!.isNotEmpty)
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: (189 / 96),
                        ),
                        itemCount: item.locations!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 189.w,
                            height: 96.h,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                              shadows: [
                                BoxShadow(
                                  color: kBoxShadowColor,
                                  blurRadius: 10.r,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, top: 10.h, right: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.locations![index]['name'],
                                    style: AppStyles.greyTextStyle().copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${item.locations![index]['quantity']}',
                                        style: AppStyles.greenTextStyle()
                                            .copyWith(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      const Icon(Icons.arrow_forward_ios)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                ]))));
  }

  List<Widget> interleaveAttributesWithSeparator(
      List<Map<String, String>> attributes, String separator) {
    List<Widget> interleavedList = [];
    for (int i = 0; i < attributes.length; i++) {
      interleavedList.add(Text(
        attributes[i]['value']!,
        style: AppStyles.greyTextStyle(),
      ));
      if (i < attributes.length - 1) {
        interleavedList.add(Text(
          separator,
          style: AppStyles.greyTextStyle(),
        ));
      }
    }
    return interleavedList;
  }

  void _showEditModal(BuildContext context, String data, Item item) {
    showModalBottomSheet(
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
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      ListTile(
                        title: Center(
                            child: Text('Copy',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          controller.copyItemToFirestore(item);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Delete',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          Navigator.pop(context);
                          _showDeleteConfirmationModal(context, data, item);
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
                    child: Text('Cancel', style: TextStyle(fontSize: 18.sp)),
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

  void _showDeleteConfirmationModal(
      BuildContext context, String data, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: kPrimaryColor.withOpacity(0.3),
                  radius: 25,
                  child: Center(
                    child: Text(
                      'i',
                      style: AppStyles.greenTextStyle().copyWith(
                          fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Are you sure?',
                  textAlign: TextAlign.center,
                  style: AppStyles.blackTextStyle()
                      .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controller.deleteItemFromFirestore(item);
                          Get.close(2);
                        },
                        child: Text('Yes', style: TextStyle(fontSize: 16.sp)),
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

  void _showUpdateModal(BuildContext context, String itemName, Item item) {
    final TextEditingController nameController =
        TextEditingController(text: item.name);
    final TextEditingController priceController =
        TextEditingController(text: item.price.toString());
    final TextEditingController costController =
        TextEditingController(text: item.cost.toString());
    final TextEditingController quantityController =
        TextEditingController(text: item.quantity.toString());
    final TextEditingController barcodeController =
        TextEditingController(text: item.barcode);

    List<TextEditingController> attributeValueControllers = [];

    for (var attribute in item.attributes) {
      attributeValueControllers
          .add(TextEditingController(text: attribute['value']));
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          contentPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Item: $itemName',
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: AppStyles.greenTextStyle(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreenContainerColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: AppStyles.greenTextStyle(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreenContainerColor),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: costController,
                    decoration: InputDecoration(
                      labelText: 'Cost',
                      labelStyle: AppStyles.greenTextStyle(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreenContainerColor),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      labelStyle: AppStyles.greenTextStyle(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreenContainerColor),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: barcodeController,
                    decoration: InputDecoration(
                      labelText: 'Barcode',
                      labelStyle: AppStyles.greenTextStyle(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreenContainerColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: List.generate(item.attributes.length, (index) {
                      return Column(
                        children: [
                          TextField(
                            controller: attributeValueControllers[index],
                            decoration: InputDecoration(
                              labelText: item.attributes[index]['name'],
                              labelStyle: AppStyles.greenTextStyle(),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kGreenContainerColor),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    width: double.infinity,
                    height: 58.h,
                    color: kPrimaryColor,
                    borderRadius: 10.r,
                    text: 'Save Changes',
                    textStyle: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {
                      List<Map<String, String>> updatedAttributes = [];
                      for (int i = 0;
                          i < attributeValueControllers.length;
                          i++) {
                        updatedAttributes.add({
                          'name': item.attributes[i]['name']!,
                          'value': attributeValueControllers[i].text,
                        });
                      }

                      Item updatedItem = Item(
                        teamId: item.teamId,
                        name: nameController.text,
                        price: double.parse(priceController.text),
                        cost: double.parse(costController.text),
                        quantity: int.parse(quantityController.text),
                        barcode: barcodeController.text,
                        image: item.image,
                        locations: item.locations,
                        attributes: updatedAttributes,
                      );

                      controller.updateItem(item.barcode, updatedItem);
                      // Get.back();
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
