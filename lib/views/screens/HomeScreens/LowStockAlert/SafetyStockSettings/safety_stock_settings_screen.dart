import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/LowStockAlert/SafetyStockSettings/controller/safety_stock_settings_controller.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

import '../../../../../utils/app_styles.dart';

class SafetyStockSettingsScreen extends GetView<SafetyStockSettingsController> {
  const SafetyStockSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Safety Stock Settings',
        centerTitle: false,
        isFullBody: false,
        actions: [
          InkWell(
            onTap: (){
              if(controller.switchController.value == true){
                GetStorage().write('alertActivated', true);
                Get.close(2);
              } else {
                GetStorage().write('alertActivated', false);
                Get.close(2);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Text(
                'Save',
                textAlign: TextAlign.center,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
        showAppBarBackButton: false,
        isCloseBackIcon: true,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeySafetyStockSettings,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Item Information Settings',
                textAlign: TextAlign.center,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                children: [
                  Text(
                    'Attribute',
                    textAlign: TextAlign.center,
                    style: AppStyles.greyTextStyle().copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: kDarkGreyButtonColor),
                  ),
                  const Spacer(),
                  Text(
                    'Safety Stock',
                    textAlign: TextAlign.center,
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 25.sp,
                  )
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 390.w,
                height: 100.h,
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
                      EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Settings',
                        textAlign: TextAlign.center,
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Safety Stock',
                            textAlign: TextAlign.center,
                            style: AppStyles.greyTextStyle().copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: kDarkGreyButtonColor),
                          ),
                          const Spacer(),
                          Text(
                            'Edit Quantity',
                            textAlign: TextAlign.center,
                            style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 25.sp,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                width: 390.w,
                height: 100.h,
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
                      EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notification Settings',
                        textAlign: TextAlign.center,
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Notifications',
                            textAlign: TextAlign.center,
                            style: AppStyles.greyTextStyle().copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: kDarkGreyButtonColor),
                          ),
                          const Spacer(),
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
                    ],
                  ),
                ),
              ),
            ])));
  }
}
