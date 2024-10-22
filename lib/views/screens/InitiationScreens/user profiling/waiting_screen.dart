import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  width: 111.w,
                  height: 111.h,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      kProfileImage,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Hey! Asaad',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Wait until we verify your profile.',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                CircularPercentIndicator(
                  radius: 100.r,
                  lineWidth: 18.w,
                  animation: true,
                  percent: 0.7,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '23:34',
                        style: AppStyles.greenTextStyle().copyWith(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'hours left.',
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: kGreenButtonColor,
                ),
                SizedBox(
                  height: 110.h,
                ),
                Text(
                  'It will take less than 2 working days ( < 48h )\nto approve your registration. ',
                  textAlign: TextAlign.center,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Center(
                  child: CustomButton(
                    width: 390.w,
                    height: 58.h,
                    color: kGreenButtonColor,
                    borderRadius: 10.r,
                    text: 'Proceed',
                    textStyle: AppStyles.whiteTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {
                      Get.toNamed(kCreateTeamRoute);

                      // showDialog(
                      //   context: context,
                      //   builder: (ctx) => AlertDialog(
                      //     backgroundColor: Colors.white,
                      //     title: Image.asset(
                      //       kAccountCreated,
                      //       height: 100.h,
                      //       width: 100.w,
                      //     ),
                      //     content: Text(
                      //       'Account created successfully',
                      //       textAlign: TextAlign.center,
                      //       style: AppStyles.blackTextStyle().copyWith(
                      //         fontSize: 18.sp,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //     ),
                      //     actions: <Widget>[
                      //       CustomButton(
                      //         width: 390.w,
                      //         height: 58.h,
                      //         color: kGreenButtonColor,
                      //         borderRadius: 10.r,
                      //         text: 'Proceed',
                      //         textStyle: AppStyles.whiteTextStyle().copyWith(
                      //           fontSize: 18.sp,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //         onPressed: () {
                      //           Navigator.of(ctx).pop();
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // )

                      ;
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
}
