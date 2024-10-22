import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/LowStockAlert/SafetyStock/controller/safety_stock_controller.dart';

class SafetyStockScreen extends GetView<SafetyStockController> {
  const SafetyStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Safety Stock',
        centerTitle: false,
        isFullBody: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(kSafetyStockSettingsRoute);
            },
            child: Padding(
                padding: EdgeInsets.only(right: 25.w),
                child: Container(
                  width: 45.w,
                  height: 35.h,
                  decoration: ShapeDecoration(
                    color: kLightGreenContainerColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: kGreenButtonColor,
                  ),
                )),
          ),
        ],
        showAppBarBackButton: false,
        isCloseBackIcon: true,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeySafetyStock,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              SizedBox(
                height: 193.h,
              ),
              Image.asset(kLock),
              SizedBox(
                height: 25.h,
              ),
              Text(
                'Add safety stock attribute\nto secure your stocks',
                textAlign: TextAlign.center,
                style: AppStyles.greyTextStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomButton(
                width: 390.w,
                height: 58.h,
                color: kLightGreenContainerColor,
                borderRadius: 10.r,
                text: 'Enable Safety Stock',
                textStyle: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: kGreenButtonColor),
                onPressed: () {
                  GetStorage().write('alertActivated', true);
                  Get.offAndToNamed(kSafetyAlertScreenRoute);
                },
              ),
            ])));
  }
}
