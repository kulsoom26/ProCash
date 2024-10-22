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

class SettingsItemsScreen extends GetView<SettingsController> {
  const SettingsItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Item Attribute',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: false,
      isBackIcon: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: GestureDetector(
              onTap: () {
                Get.toNamed(kSettingsAddItemsRoute);
              },
              child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: kPrimaryColor.withOpacity(0.2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                ),
              )),
        )
      ],
      scaffoldKey: controller.scaffoldKeyItems,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: Obx(() {
                return ListView.separated(
                  itemCount: controller.itemAttribute.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    var data = controller.itemAttribute[index];
                    return Container(
                      width: Get.width,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: kGreyContainerColor,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            Text(
                              data['name'],
                              style: AppStyles.blackTextStyle()
                                  .copyWith(fontSize: 15.sp),
                            ),
                            const Spacer(),
                            Text(
                              data['type'],
                              style: AppStyles.greenTextStyle()
                                  .copyWith(fontSize: 14.sp),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showEditModal(context, data);
                              },
                              child: Image.asset(
                                kEditIcon,
                                width: 20.w,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditModal(BuildContext context, Map<String, dynamic> data) {
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
                          'Attribute Options',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Rename Attribute',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          Navigator.pop(context);
                          _showRenameModal(context, data);
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Delete Attribute',
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

  void _showRenameModal(BuildContext context, Map<String, dynamic> data) {
    TextEditingController renameController =
        TextEditingController(text: data['name']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Rename Attribute',
                    style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15.h,
                ),
                Text('Input New Name',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 15.sp,
                    )),
                SizedBox(height: 20.h),
                TextField(
                  controller: renameController,
                  decoration: const InputDecoration(
                    hintText: 'Input new name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
  children: [
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel', style:AppStyles.blackTextStyle().copyWith(fontSize: 18.sp)),
      ),
    ),
    SizedBox(width: 10.w), 
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: () {
          String newName = renameController.text;
          if (newName.isNotEmpty) {
            controller.renameAttribute(data, newName);
          }
          Navigator.pop(context);
        },
        child: Text('OK', style: TextStyle(fontSize: 16.sp)),
      ),
    ),
  ],
)

              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationModal(
      BuildContext context, Map<String, dynamic> data) {
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
                  backgroundColor: kRedTextColor,
                  radius: 25,
                  child: Center(
                    child:
                        Icon(Icons.delete, size: 30.w, color: kWhiteTextColor),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Delete Attribute!',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: kRedTextColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Really Delete "${data['name']}" Attribute?',
                  textAlign: TextAlign.center,
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 15.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 20.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 20.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        controller.deleteAttribute(data);
                      },
                      child: Text('Delete', style: TextStyle(fontSize: 16.sp)),
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
