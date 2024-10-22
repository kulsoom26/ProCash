import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/AdminScreens/AdminHome/controller/admin_home_controller.dart';

class AdminHomeScreen extends GetView<AdminHomeController> {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
            className: runtimeType.toString(),
            screenName: '',
            centerTitle: false,
            isFullBody: false,
            showAppBarBackButton: false,
            isBackIcon: false,
            
            isCloseBackIcon: false,
            scaffoldKey: controller.scaffoldKeyAdminHome,
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Good Morning ',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Admin',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                     onTap: () {
                        Get.toNamed(kAdminRequestRoute);
                      },
                    child: Container(
                      width: 390.w,
                      height: 97.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
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
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Row(
                          children: [
                            Container(
                              width: 70.w,
                              height: 57.h,
                              decoration: ShapeDecoration(
                                color: kGreyColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Image.asset(kUserRequestImage),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'Join Requests ',
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Obx(
                              () => Text(
                                    '${controller.requestNo.value}',
                                style: AppStyles.blackTextStyle().copyWith(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Image.asset(kAdminImage),
                  SizedBox(
                    height: 70.h,
                  ),
                  Center(
                    child: CustomButton(
                      width: 390.w,
                      height: 58.h,
                      color: kStock1TextColor,
                      borderRadius: 10.r,
                      text: 'LogOut',
                      textStyle: AppStyles.whiteTextStyle().copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      onPressed: () {
                        Get.offAllNamed(kLogInRoute);
                      },
                    ),
                  ),
                ]))));
  }
}
