import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_text_field.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 70.h,
        ),
        Center(child: Image.asset(kAppLogo)),
        SizedBox(
          height: 50.h,
        ),
        Text(
          'Login to your Account',
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        CustomTextField(
          controller: controller.loginEmail,
          hinttext: 'Email',
          color: kBlackTextColor,
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          controller: controller.loginPassword,
          hinttext: 'Password',
          color: kBlackTextColor,
          isPassword: true,
        ),
        SizedBox(
          height: 40.h,
        ),
        Obx(
          () => Center(
            child: controller.isLoading.isTrue? CircularProgressIndicator(color: kGreenButtonColor,) :CustomButton(
              width: 390.w,
              height: 58.h,
              color: kGreenButtonColor,
              borderRadius: 10.r,
              text: 'Sign In',
              textStyle: AppStyles.whiteTextStyle().copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              onPressed: () {
                if (controller.loginEmail.text == 'admin123@gmail.com' &&
                    controller.loginPassword.text == '12345678') {
                  Get.toNamed(kAdminHomeRoute);
                } else if (controller.loginEmail.text == '' ||
                    controller.loginPassword.text == '') {
                  Get.snackbar('Invalid Input!!',
                      'All fields are required, please enter again');
                } else {
                  controller.login();
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Center(
          child: Text(
            'Or sign in with',
            style: AppStyles.greyTextStyle().copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        GestureDetector(
          onTap: (){
            controller.handleGoogleSignIn();
          },
          child: Center(
            child: Container(
              width: 360.w,
                height: 58.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: kGreenButtonColor, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    kGoogle2Icon,
                    height: 60.h,
                  ),
                  Text(
                    'Sign In with Google',
                    style: AppStyles.greenTextStyle(),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account? ',
              style: AppStyles.greyTextStyle().copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(kSignUpRoute);
              },
              child: Text(
                'Sign up',
                style: AppStyles.greenTextStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ]),
    ))));
  }
}
