import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Transactions/controller/transaction_controller.dart';

class TransactionsScreen extends GetView<TransactionsController> {
  const TransactionsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
            className: runtimeType.toString(),
            screenName: 'Transactions',
            centerTitle: false,
            isFullBody: false,
            showAppBarBackButton: false,
            isCloseBackIcon: false,
            isBackIcon: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Container(
                  width: 45.w,
                  height: 35.h,
                  decoration: ShapeDecoration(
                    color: kLightGreenContainerColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: const Icon(
                    Icons.calendar_month_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              )
            ],
            scaffoldKey: controller.scaffoldKeyTransactions,
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: 390.w,
                    height: 147.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 25.w, top: 18.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(kStock1Icon),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    'Stock In',
                                    style: AppStyles.redTextStyle().copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 35.w,
                                  ),
                                  Text(
                                    '5/28/2024 | 15:51',
                                    style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Warehouse 1',
                                    style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 35.w,
                                  ),
                                  Text(
                                    'Asaad 1 | Asaad 2',
                                    style: AppStyles.greyTextStyle().copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          height: 2.h,
                          width: 390.w,
                          color: kRedTextColor,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 45.w, right: 45.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Old Quantity',
                                    style: AppStyles.greyTextStyle().copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '300',
                                    style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'New Quantity',
                                    style: AppStyles.greyTextStyle().copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '+300',
                                    style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]))));
  }
}
