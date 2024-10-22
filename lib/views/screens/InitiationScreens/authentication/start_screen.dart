import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/controller/auth_controller.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});


  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 160.h,
              ),
              Center(
                child: Container(
                  width: 251.w,
                  height: 87.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(kAppLogo),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 296.h,
              ),
              Text(
                'Join Using',
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.handleGoogleSignIn(); 
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kGoogleIcon,
                    ),
                    
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1.h,
                    width: 100.w,
                    color: kDarkGreyButtonColor,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'OR',
                    style: AppStyles.greyTextStyle().copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 1.h,
                    width: 100.w,
                    color: kDarkGreyButtonColor,
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start with ',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(kLogInRoute);
                    },
                    child: Text(
                      'Email',
                      style: AppStyles.greenTextStyle().copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
