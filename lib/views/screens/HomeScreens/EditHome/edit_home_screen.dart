import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/EditHome/controller/edit_home_controller.dart';

class EditHomeScreen extends GetView<EditHomeController> {
  const EditHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
            className: runtimeType.toString(),
            screenName: 'Edit Home',
            centerTitle: false,
            isFullBody: false,
            showAppBarBackButton: false,
            isCloseBackIcon: false,
            isBackIcon: true,
            scaffoldKey: controller.scaffoldKeyEditHome,
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    'Add Shortcut(s)',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildShortcutContainer('Stocks', controller),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildShortcutContainer('Low Stock Alert', controller),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildShortcutContainer('Add Items', controller),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildShortcutContainer('Inventory Count', controller),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildShortcutContainer('Add Members', controller),
                  SizedBox(
                    height: 15.h,
                  ),
                ]))));
  }

  Widget _buildShortcutContainer(String title, EditHomeController controller) {
    return Container(
      width: 350.w,
      height: 93.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
        padding: EdgeInsets.only(left: 25.w, right: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.addWidget(title);
                    },
                    child: Container(
                      width: 106.w,
                      height: 30.h,
                      decoration: ShapeDecoration(
                        color: kLightGreenContainerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Center(
                        child: Text(
                          'Add ',
                          style: AppStyles.redTextStyle().copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      controller.removeWidget(title);
                    },
                    child: Container(
                      width: 106.w,
                      height: 30.h,
                      decoration: ShapeDecoration(
                        color: kLightRedContainerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Center(
                        child: Text(
                          'Remove',
                          style: AppStyles.redTextStyle().copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
