import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_image_picker.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_text_field.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/user%20profiling/controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: '',
        centerTitle: false,
        isFullBody: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(kProfile1Route);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                'skip',
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
        showAppBarBackButton: true,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeyProfile,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add User Details',
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 40.h),
              CustomProfileImagePicker(),
             
              SizedBox(height: 50.h),
              CustomTextField(
                controller: controller.name,
                hinttext: 'User Name',
                color: kBlackTextColor,
              ),
              SizedBox(height: 15.h),
              Align(
                child: Text(
                  'Name must contain at least 1 character.',
                  textAlign: TextAlign.center,
                  style: AppStyles.greyTextStyle().copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 310.h),
              Center(
                child: CustomButton(
                  width: 390.w,
                  height: 58.h,
                  color: kGreenButtonColor,
                  borderRadius: 10.r,
                  text: 'Next',
                  textStyle: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  onPressed: () {
                    if(controller.name.text == ''){
                      Get.snackbar("Invalid Name!!", "Please enter a valid name.");
                    } else {
                      Get.toNamed(kProfile1Route);
                    }
                    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
  ProfileController controller = Get.put(ProfileController());

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
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
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
                              fontWeight: FontWeight.w500,),
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
                    child: Text('Cancel', style: AppStyles.blackTextStyle().copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold)),
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
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Obx(
            () => Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kWhiteButtonColor, width: 2),
              ),
              child: controller.isUploading.isTrue
                  ? CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : controller.imagePath.value.isEmpty
                      ? CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.transparent,
                          foregroundColor: kPrimaryColor,
                          backgroundImage: AssetImage(kProfileImage),
                        )
                      : CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.transparent,
                          foregroundColor: kPrimaryColor,
                          backgroundImage:
                              NetworkImage(controller.imagePath.value),
                        ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              _getImageFromCameraOrGallery(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGreyButtonColor,
                border: Border.all(
                  color: kWhiteButtonColor,
                  width: 1.5
                )
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.photo_camera,
                color: kWhiteButtonColor,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

