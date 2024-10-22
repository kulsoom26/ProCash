import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../../utils/app_images.dart';
import '../../custom_widgets/custom_textfield.dart';

class UserProfilingScreen extends GetView<SettingsController> {
  const UserProfilingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.userName.text = GetStorage().read('name');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: kBlackTextColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: kGreyButtonColor,
            height: 1,
          ),
        ),
      ),
      key: controller.scaffoldKeyUserProfiling,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: Get.width,
                height: 300.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: kGreyButtonColor)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomProfileImagePicker(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: CustomTextField1(
                        label: 'Name:',
                        hint: 'Enter your name',
                        controller: controller.userName,
                        isEditable: true,
                        isSuffix: GestureDetector(
                            onTap: () {
                              _showRenameModal(context, controller.userName);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: kGreyButtonColor,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    
                    
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Settings',
                style: AppStyles.blackTextStyle()
                    .copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sound',
                    style: AppStyles.greyTextStyle().copyWith(color: kGrayButtonColor, fontSize: 17.sp),
                  ),
                  Obx(() => CupertinoSwitch(
                        activeColor: kPrimaryColor,
                        value: controller.isSound.value,
                        onChanged: (bool value) {
                          controller.isSound.value = value;
                        },
                      )),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vibration',
                    style: AppStyles.greyTextStyle().copyWith(color: kGrayButtonColor, fontSize: 17.sp),
                  ),
                  Obx(() => CupertinoSwitch(
                        activeColor: kPrimaryColor,
                        value: controller.isVibration.value,
                        onChanged: (bool value) {
                          controller.isVibration.value = value;
                        },
                      )),
                ],
              ), SizedBox(height: 50.h,),
              Center(
                child: GestureDetector(
                  onTap: (){
                    controller.logout();
                  },
                  child: Container(
                    width: 180.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: kRedButtonColor.withOpacity(0.3)
                    ),
                    child: Center(
                      child: Text('Log Out', style: AppStyles.redTextStyle().copyWith(
                        fontSize: 18.sp
                      ),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showRenameModal(
      BuildContext context, TextEditingController controllerText) {
    TextEditingController _renameController =
        TextEditingController(text: controllerText.text);

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
                Text('Update Name',
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
                  controller: _renameController,
                  decoration: InputDecoration(
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
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 20.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',
                            style: AppStyles.blackTextStyle()
                                .copyWith(fontSize: 18.sp)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 20.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controllerText.text = _renameController.text;
                          controller.updateUsername(controllerText.text.trim());
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
}


class CustomProfileImagePicker extends StatefulWidget {
  const CustomProfileImagePicker({super.key});

  @override
  State<CustomProfileImagePicker> createState() =>
      _CustomProfileImagePickerState();
}

class _CustomProfileImagePickerState extends State<CustomProfileImagePicker> {
  SettingsController controller = Get.put(SettingsController());

  Future<void> _getImageFromCameraOrGallery(BuildContext context) async {
    await showModalBottomSheet<File?>(
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
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          textAlign: TextAlign.center,
                          'Camera',
                          style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          await controller.getImageCamera();
                        },
                      ),
                      Divider(height: 1.h),
                      ListTile(
                        title: Text(
                          textAlign: TextAlign.center,
                          'Gallery',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          await controller.getImageGallery();
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
                    child: Text('Cancel',
                        style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => controller.isUploading.isTrue
            ? CircularProgressIndicator(
                color: kPrimaryColor,
              )
            : controller.imagePath.value.isEmpty 
                ? GetStorage().read('image') != '' ? Center(
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 150.w,
                          height: 150.h,
                          child: Image.network(
                            GetStorage().read('image'),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 50,
                          child: GestureDetector(
                            onTap: () async {
                              _getImageFromCameraOrGallery(context);
                            },
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: ShapeDecoration(
                                color: kGreyButtonColor,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    width: 2.w,
                                    color: kWhiteTextColor,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: kWhiteTextColor,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):Center(
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 150.w,
                          height: 150.h,
                          child: Image.asset(
                            kProfileImage,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 50,
                          child: GestureDetector(
                            onTap: () async {
                              _getImageFromCameraOrGallery(context);
                            },
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: ShapeDecoration(
                                color: kGreyButtonColor,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    width: 2.w,
                                    color: kWhiteTextColor,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: kWhiteTextColor,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      controller.imagePath.value))),
                        ),
                        Positioned(
                          right: 45,
                          bottom: 50,
                          child: GestureDetector(
                            onTap: () async {
                              _getImageFromCameraOrGallery(context);
                            },
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: ShapeDecoration(
                                color: kGreyButtonColor,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    width: 2.w,
                                    color: kWhiteTextColor,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: kWhiteTextColor,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
