import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_text_field.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
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
          'Create Team Account',
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        CustomTextField(
          controller: controller.email,
          hinttext: 'Email',
          color: kBlackTextColor,
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          controller: controller.password,
          hinttext: 'Password',
          color: kBlackTextColor,
          isPassword: true,
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          controller: controller.confirmPassword,
          hinttext: 'Confirm Password',
          color: kBlackTextColor,
          isPassword: true,
        ),
        SizedBox(
          height: 40.h,
        ),
        Center(
          child: CustomButton(
            width: 390.w,
            height: 58.h,
            color: kGreenButtonColor,
            borderRadius: 10.r,
            text: 'Start',
            textStyle: AppStyles.whiteTextStyle().copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            onPressed: () {
              if(controller.email.text == '' || controller.password.text == '' || controller.confirmPassword.text == ''){
                Get.snackbar('Invalid Input!!', 'All fields are required, please enter data for all fields');
              } else if(controller.password.text != controller.confirmPassword.text){
                Get.snackbar('Password Mismatch!!', 'Passwords do not match, please enter again.');
              }
              else {
              Get.toNamed(kOnBoardingRoute);}
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: Text(
            'Or sign up with',
            style: AppStyles.greyTextStyle().copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
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
                    'Sign Up with Google',
                    style: AppStyles.greenTextStyle(),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: AppStyles.greyTextStyle().copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(kLogInRoute);
              },
              child: Text(
                'Sign in',
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
