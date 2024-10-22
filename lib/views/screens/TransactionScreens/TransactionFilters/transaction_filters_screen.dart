import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/TransactionFilters/controller/transaction_filter_controller.dart';

class TransactionFilterScreen extends GetView<TransactionFilterController> {
  const TransactionFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Filters',
        centerTitle: false,
        isFullBody: false,
        showAppBarBackButton: true,
        isBackIcon: true,
        isCloseBackIcon: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Text(
              'Clear',
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
        scaffoldKey: controller.scaffoldKeyTransactionFilter,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stock',
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    SwitchRow(
                      title: 'All',
                      controller: controller.switchController1,
                    ),
                    SizedBox(height: 10.h),
                    SwitchRow(
                      title: 'Stock In',
                      controller: controller.switchController2,
                    ),
                    SizedBox(height: 10.h),
                    SwitchRow(
                      title: 'Stock Out',
                      controller: controller.switchController3,
                    ),
                    SizedBox(height: 10.h),
                    SwitchRow(
                      title: 'Adjust',
                      controller: controller.switchController4,
                    ),
                    SizedBox(height: 10.h),
                    SwitchRow(
                      title: 'Move',
                      controller: controller.switchController5,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SwitchRow(
                title: 'Date',
                controller: controller.switchController6,
              ),
              SizedBox(height: 15.h),
              DateRangePicker(),
              SizedBox(height: 15.h),
              SwitchRow(
                title: 'Location',
                controller: controller.switchController7,
              ),
              SizedBox(height: 15.h),
              const OptionRow(
                title: 'All',
              ),
              SizedBox(height: 15.h),
              SwitchRow(
                title: 'Items',
                controller: controller.switchController8,
              ),
              SizedBox(height: 15.h),
              const OptionRow(
                title: 'All',
              ),
              SizedBox(height: 15.h),
              SwitchRow(
                title: 'Partners',
                controller: controller.switchController9,
              ),
              SizedBox(height: 15.h),
              const OptionRow(
                title: 'All',
              ),
              SizedBox(height: 30.h),
              Center(
                child: CustomButton(
                  width: 390.w,
                  height: 58.h,
                  color: kGreenButtonColor,
                  borderRadius: 10.r,
                  text: 'Apply',
                  textStyle: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  onPressed: () {
                    // Get.toNamed(kNavBarRoute);
                  },
                ),
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchRow extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> controller;

  const SwitchRow({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        AdvancedSwitch(
          controller: controller,
          activeColor: kGreenButtonColor,
          inactiveColor: kGreyTextColor,
          borderRadius: BorderRadius.circular(12.r),
          width: 40.w,
          height: 19.h,
        ),
      ],
    );
  }
}

class OptionRow extends StatelessWidget {
  final String title;

  const OptionRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 50.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const DateContainer(
          title: 'From',
        ),
        SizedBox(width: 10.w),
        Text(
          '-',
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10.w),
        const DateContainer(
          title: 'To',
        ),
      ],
    );
  }
}

class DateContainer extends StatelessWidget {
  final String title;

  const DateContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.w,
      height: 40.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        shadows: [
          BoxShadow(
            color: kBoxShadowColor,
            blurRadius: 10.r,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
