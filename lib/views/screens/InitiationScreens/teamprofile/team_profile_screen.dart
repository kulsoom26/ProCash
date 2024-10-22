import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_text_field.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/teamprofile/controller/team_profile_controller.dart';

class TeamProfileScreen extends GetView<TeamProfileController> {
  const TeamProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: '',
        centerTitle: false,
        isFullBody: false,
        showAppBarBackButton: true,
        isBackIcon: true,
        isCloseBackIcon: true,
        scaffoldKey: controller.scaffoldKeyTeamProfile,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Join or Create New Team',
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              const CustomProfileImagePicker(),
              SizedBox(height: 30.h),
              CustomTextField(
                controller: controller.teamname,
                hinttext: 'Team Name',
                color: kBlackTextColor,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.teamCode,
                hinttext: 'Team Code',
                color: kBlackTextColor,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.description,
                hinttext: 'Description',
                color: kBlackTextColor,
                maxLines: 5,
              ),
              SizedBox(height: 40.h),
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
                    Get.toNamed(kSelectModeRoute);
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
  TeamProfileController controller = Get.put(TeamProfileController());

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
            ? const CircularProgressIndicator(
                color: kPrimaryColor,
              )
            : controller.imagePath.value.isEmpty
                ? Center(
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 150.w,
                          height: 150.h,
                          child: Image.asset(
                            kTeamProfile,
                          ),
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
                  )
                : Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(controller.imagePath.value))
                          ),
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
