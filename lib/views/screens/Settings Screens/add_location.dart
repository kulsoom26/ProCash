import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../custom_widgets/custom_textfield.dart';

class AddLocationScreen extends GetView<SettingsController> {
  const AddLocationScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    controller.locationName.text = "Enter Location";
    controller.locationDescription.text = "Write a note";
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: '',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyAddlocation,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: GestureDetector(
            onTap: () {
              controller.addLocation(controller.locationName.text.trim());
              Get.back();
            },
            child: Container(
              width: Get.width,
              height: 59.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: kPrimaryColor,
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: AppStyles.whiteTextStyle()
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location Information',
                    style: AppStyles.blackTextStyle()
                        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //   },
                  //   child: Container(
                  //     width: 40.w,
                  //     height: 40.h,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8.r),
                  //         color:kPrimaryColor.withOpacity(0.3)),
                  //     child: Center(
                  //       child: Image.asset(kEditIcon, color: kPrimaryColor, width: 25.w,)
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(height:40.h),
              CustomTextField1(
                label: 'Name:',
                hint: 'Enter Name',
                controller: controller.locationName,
                isEditable: false,
                isSuffix: Icon(Icons.keyboard_arrow_right, color: kGreyButtonColor,),
              ),
                SizedBox(height: 28.h,),
                GestureDetector(
                  
                  child: CustomTextField1(
                    label: 'Description:',
                    hint: 'Write a note',
                    isEditable: false,
                    controller: controller.locationDescription,
                    maxLines: 9,
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }
  void _showEditModal(BuildContext context, TextEditingController controller) {
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
                            child: Text('Text',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          controller.text = 'Text';
                          Navigator.pop(context);
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Number',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          controller.text = 'Number';
                          Navigator.pop(context);
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Date',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          controller.text = 'Date';
                          Navigator.pop(context);
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Center(
                            child: Text('Barcode',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          controller.text = 'Barcode';
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(color: Colors.black),
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
}
