
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart'; // Ensure this contains the path to the success image
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/controller/auth_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/user%20profiling/controller/profile_controller.dart';

import '../../../../models/request_model.dart';

class ProfileScreen1 extends StatelessWidget {
  ProfileScreen1({super.key});
  ProfileController controller = Get.put(ProfileController());
  AuthController controller1 = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  width: 111.w,
                  height: 111.h,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                  ),
                  child: Obx(
                    () => ClipOval(
                      child: controller.imagePath.value == ''
                          ? Image.asset(kProfileImage)
                          : Image.network(controller.imagePath.value),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Hey! ${controller.name.text}',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 45.h,
                ),
                Image.asset(kImage5),
                SizedBox(
                  height: 75.h,
                ),
                Center(
                  child: Text(
                    'To create account and start using this App, \napply for registration. ',
                    textAlign: TextAlign.center,
                    style: AppStyles.greyTextStyle().copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: CustomButton(
                    width: 390.w,
                    height: 58.h,
                    color: kGreenButtonColor,
                    borderRadius: 10.r,
                    text: 'Apply Registration',
                    textStyle: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {
                      _showRegistrationDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRegistrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  kRequestSent,
                  width: 80.w,
                  height: 80.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Request sent successfully, please wait!!',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  width: 150.w,
                  height: 40.h,
                  color: kGreenButtonColor,
                  borderRadius: 10.r,
                  text: 'Proceed',
                  textStyle: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Request request = Request(
                      name: controller.name.text,
                      email: controller1.email.text,
                      password: controller1.password.text,
                      image: controller.imagePath.value,
                      isTeamJoined: false
                    );
                    controller.addRequest(request);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
