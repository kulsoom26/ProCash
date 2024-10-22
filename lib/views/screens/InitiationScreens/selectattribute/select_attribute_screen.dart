import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/selectattribute/controller/select_attribute_controller.dart';

import '../../../../models/attributes_model.dart';

class SelectAttribute extends StatelessWidget {
  const SelectAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectAttributeController controller =
        Get.put(SelectAttributeController());

    final attributes = [
      Attribute(name: 'Type', type: 'Text'),
      Attribute(name: 'Color', type: 'Text'),
      Attribute(name: 'Storage', type: 'Text'),
      Attribute(name: 'Note', type: 'Text'),
      // Attribute(name: 'Add New', type: 'Text'),
      Attribute(name: 'Brand', type: 'Text'),
      Attribute(name: 'Manufacturer', type: 'Text'),
      Attribute(name: 'Size', type: 'Text'),
      Attribute(name: 'Lot Number', type: 'Text'),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add attributes to organize\nyour inventory.',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Select all that apply.',
                  style: AppStyles.greyTextStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: attributes.sublist(0, 4).map((attribute) {
                        return MyContainer(
                          attribute: attribute,
                          controller: controller,
                        );
                      }).toList(),
                    ),
                    Column(
                      children: attributes.sublist(4).map((attribute) {
                        return MyContainer(
                          attribute: attribute,
                          controller: controller,
                        );
                      }).toList(),
                    )
                  ],
                ),
                SizedBox(
                  height: 255.h,
                ),
                Center(
                  child: CustomButton(
                    width: 390.w,
                    height: 58.h,
                    color: kGreenButtonColor,
                    borderRadius: 10.r,
                    text: 'Create Team',
                    textStyle: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {
                      Get.toNamed(kAgreementRoute);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  final Attribute attribute;
  final SelectAttributeController controller;

  const MyContainer({
    super.key,
    required this.attribute,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.toggleAttributeSelection(attribute);
      },
      child: Obx(
        () {
          bool isSelected = controller.isSelected(attribute);
          return Container(
            width: 184.w,
            height: 45.h,
            margin: EdgeInsets.only(bottom: 15.h),
            decoration: ShapeDecoration(
              color: isSelected ? kGreenButtonColor : Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Center(
              child: Text(
                attribute.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 15.sp,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
