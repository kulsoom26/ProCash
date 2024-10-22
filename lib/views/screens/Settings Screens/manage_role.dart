import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

class ManageRolesScreen extends GetView<SettingsController> {
  const ManageRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Manage Roles',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: false,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyManageRoles,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 55.h,
              decoration: BoxDecoration(
                border: Border.all(color: kGreyTextColor, width: 1.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Row(
                  children: [
                    Image.asset(
                      kRole,
                      width: 35.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Manager',
                      style: AppStyles.blackTextStyle()
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          _showEditModal(context, 'Manager');
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                          color: kGreyButtonColor,
                          size: 25,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: Get.width,
              height: 55.h,
              decoration: BoxDecoration(
                border: Border.all(color: kGreyTextColor, width: 1.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Row(
                  children: [
                    Image.asset(
                      kRole,
                      width: 35.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Manager',
                      style: AppStyles.blackTextStyle()
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                          color: kGreyButtonColor,
                          size: 25,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(kSettingsAddNewRoleRoute);
              },
              child: Container(
                width: Get.width,
                height: 55.h,
                decoration: BoxDecoration(
                  border: Border.all(color: kGreyTextColor, width: 1.5),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Add New Role',
                      style: AppStyles.blackTextStyle()
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showEditModal(BuildContext context, String data) {
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
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        alignment: Alignment.center,
                        child: Text(
                          'Role Settings',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Edit Role',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(kSettingsAddNewRoleRoute);
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Delete Role',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          Navigator.pop(context);
                          _showDeleteConfirmationModal(context, data);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: const BorderSide(color: Colors.black),
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

  void _showDeleteConfirmationModal(BuildContext context, String data) {
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
                            side: const BorderSide(color: Colors.black),
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
                          Navigator.pop(context);
                          // controller.deleteAttribute(data);
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
}
