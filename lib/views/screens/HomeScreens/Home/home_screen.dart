import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/customized_barcode.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Home/controller/home_screen_controller.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              'Home',
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  width: 390.w,
                  height: 219.h,
                  decoration: ShapeDecoration(
                    color: kLightGreenContainerColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                                  controller.isToday.value
                                      ? 'Today: ${controller.date.value}'
                                      : 'Yesterday: ${controller.date.value}',
                                  style: AppStyles.greenTextStyle().copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: kGreenButtonColor,
                                size: 20.sp,
                              ),
                              onPressed: controller.toggleDate,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 31.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 110.w,
                              height: 110.h,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [kGradient1Color, kGradient2Color],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  SvgPicture.asset(
                                    kTotalIcon,
                                  ),
                                  Text(
                                    'Total',
                                    style: AppStyles.whiteTextStyle().copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.totalQuantityInLocations.value}',
                                      style: AppStyles.whiteTextStyle().copyWith(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 110.w,
                              height: 110.h,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [kGradient1Color, kGradient2Color],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  SvgPicture.asset(
                                    kStockInIcon,
                                  ),
                                  Text(
                                    'Stock In',
                                    style: AppStyles.whiteTextStyle().copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.isToday.isTrue ?'${controller.totalStockInToday.value}' : '${controller.totalStockInYesterday.value}',
                                      style: AppStyles.whiteTextStyle().copyWith(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 110.w,
                              height: 110.h,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [kGradient1Color, kGradient2Color],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  SvgPicture.asset(
                                    kStockOutIcon,
                                  ),
                                  Text(
                                    'Stock Out',
                                    style: AppStyles.whiteTextStyle().copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.isToday.isTrue ?'${controller.totalStockOutToday.value}' : '${controller.totalStockOutYesterday.value}',
                                      style: AppStyles.whiteTextStyle().copyWith(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: 390.w,
                  height: 196.h,
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
                    padding: EdgeInsets.only(top: 15.h, left: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stocks',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(kStockInRoute);
                          },
                          child: CustomRow(
                            image: AssetImage(kInIcon),
                            text: 'Stock In',
                          ),
                        ),
                        SizedBox(
                          height: 17.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(kStockOutRoute);
                          },
                          child: CustomRow(
                            image: AssetImage(kOutIcon),
                            text: 'Stock Out',
                          ),
                        ),
                        SizedBox(
                          height: 17.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(kAdjustStockRoute);
                          },
                          child: CustomRow(
                            image: AssetImage(kAdjustIcon),
                            text: 'Adjust',
                          ),
                        ),
                        SizedBox(
                          height: 17.w,
                        ),
                        Obx(() => controller.mode.value == 'Location Mode' ? GestureDetector(
                            onTap: () {
                              Get.toNamed(kMoveStockRoute);
                            },
                            child: CustomRow(
                              image: AssetImage(kMoveIcon),
                              text: 'Move',
                            ),
                          ): Container())
                          
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: 390.w,
                  height: 91.h,
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
                    padding: EdgeInsets.only(top: 15.h, left: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Low Stock Alert',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            if(GetStorage().read('alertActivated')){
                              Get.toNamed(kSafetyAlertScreenRoute);
                            } else {
                              Get.toNamed(kSafetyStockRoute);
                            }
                            
                          },
                          child: CustomRow(
                            image: AssetImage(kStockIcon),
                            text: 'Check Stock Shortage',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: 390.w,
                  height: 91.h,
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
                    padding: EdgeInsets.only(top: 15.h, left: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inventory Count',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CustomisedSimpleBarcodeScannerPage(result: controller.count,),
                              ),
                            );
                            if (result != null) {
                              print('Barcode result: $result');
                            }
                          },
                          child: CustomRow(
                            image: AssetImage(kCountIcon),
                            text: 'Scan and Count',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: 390.w,
                  height: 91.h,
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
                    padding: EdgeInsets.only(top: 15.h, left: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Members',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(kAddMembersRoute);
                          },
                          child: CustomRow(
                            image: AssetImage(kAddMemberIcon),
                            text: 'Invite Team Members',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
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
                    padding: EdgeInsets.only(top: 15.h, left: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Items',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(kRegisterNewItemsRoute);
                          },
                          child: CustomRow(
                            image: AssetImage(kAddItemIcon),
                            text: 'Register New Items',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                // Center(
                //   child: Container(
                //     width: 129.w,
                //     height: 105.h,
                //     decoration: ShapeDecoration(
                //       color: Colors.white,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8.r)),
                //       shadows: [
                //         BoxShadow(
                //           color: kBoxShadowColor,
                //           blurRadius: 10.r,
                //           offset: const Offset(0, 0),
                //           spreadRadius: 0,
                //         )
                //       ],
                //     ),
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           height: 20.h,
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             Get.toNamed(kEditHomeRoute);
                //           },
                //           child: Container(
                //             width: 50.w,
                //             height: 40.h,
                //             decoration: ShapeDecoration(
                //               color: kLightGreenContainerColor,
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(8.r)),
                //             ),
                //             child: const Icon(
                //               Icons.add,
                //               color: kGreenButtonColor,
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           height: 11.h,
                //         ),
                //         Text(
                //           'Add More',
                //           style: AppStyles.blackTextStyle().copyWith(
                //             fontSize: 18.sp,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 25.h,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final AssetImage image;
  final String text;

  const CustomRow({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(image: image),
        SizedBox(
          width: 20.w,
        ),
        Text(
          text,
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 20.sp,
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}
