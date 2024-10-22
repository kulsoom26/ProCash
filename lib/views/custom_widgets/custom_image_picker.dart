import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../utils/app_styles.dart';

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
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 20.h),
          child: Wrap(
            children: <Widget>[
              Center(
                child: Text(
                  'Choose your preference',
                  style: AppStyles.appBarHeadingTextStyle().copyWith(
                      fontSize: 20.sp,
                      color: kBlackButtonColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera,
                  color: kBlackButtonColor,
                ),
                title: Text(
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
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: kBlackButtonColor,
                ),
                title: Text(
                  'Gallery',
                  style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await controller.getImageGallery();
                },
              ),
            ],
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
                  ? const CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : controller.imagePath.value.isEmpty
                      ? CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.transparent,
                          foregroundColor: kPrimaryColor,
                          backgroundImage: AssetImage(kDummy1),
                        )
                      : CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.transparent,
                          foregroundColor: kPrimaryColor,
                          backgroundImage:
                              FileImage(File(controller.imagePath.value)),
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
              padding: const EdgeInsets.all(6),
              child: const Icon(
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
