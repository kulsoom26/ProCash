import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../custom_widgets/custom_textfield.dart';

class AddItemScreen extends GetView<SettingsController> {
  const AddItemScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    controller.attributeName.text = "Input Attribute Name";
    controller.attributeType.text = "Input Attribute Type";
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: '',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyAddItem,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: GestureDetector(
            onTap: () {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('New Attribute', style: AppStyles.blackTextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 46.h,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomTextField1(
                  label: 'Name:',
                  hint: 'Input Attribute Name',
                  controller: controller.attributeName,
                  isEditable: false,
                  isSuffix: const Icon(Icons.keyboard_arrow_right, color: kGreyButtonColor,),
                ),
              ),
              SizedBox(height: 28.h,),
              GestureDetector(
                
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomTextField1(
                    label: 'Type:',
                    hint: 'Input Attribute Type',
                    isEditable: true,
                    controller: controller.attributeType,
                    isSuffix: GestureDetector(
                      onTap: (){
                  _showEditModal(context, controller.attributeType);
                },
                      child: const Icon(Icons.keyboard_arrow_down, color: kGreyButtonColor,)),
                  ),
                ),
              ),
          ],
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
}
