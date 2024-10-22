import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/selectmode/controller/select_mode_controller.dart';

class SelectMode extends StatelessWidget {
  const SelectMode({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectModeController controller = Get.put(SelectModeController());

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
                  'Select a mode that best\nfits your needs.',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Select carefully, after Team’s creation you can not edit mode.',
                  style: AppStyles.greyTextStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 80.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectMode(1);
                      },
                      child: Obx(
                        () => Container(
                          width: 184.w,
                          height: 226.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.50.w,
                                color: controller.selectedIndex.value == 1
                                    ? kGreenButtonColor
                                    : kGreyButtonColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, right: 10.w),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    decoration: const BoxDecoration(
                                      color: kLightGreenContainerColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(kInfoIcon),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Image.asset(kBasicMode),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  'Basic Mode',
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Manage inventory\nand item quantity.',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.greyTextStyle().copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectMode(2);
                      },
                      child: Obx(
                        () => Container(
                          width: 184.w,
                          height: 226.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.50.w,
                                color: controller.selectedIndex.value == 2
                                    ? kGreenButtonColor
                                    : kGreyButtonColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, right: 10.w),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    decoration: const BoxDecoration(
                                      color: kLightGreenContainerColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(kInfoIcon),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Image.asset(kLocationMode),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  'Location Mode',
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Manage scattered\nitems at various\nlocation easily.',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.greyTextStyle().copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 230.h,
                ),
                Center(
                  child: CustomButton(
                    width: 390.w,
                    height: 58.h,
                    color: kGreenButtonColor,
                    borderRadius: 10.r,
                    text: 'Next',
                    textStyle: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {
                      Get.toNamed(kSelectAttributeRoute);
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
