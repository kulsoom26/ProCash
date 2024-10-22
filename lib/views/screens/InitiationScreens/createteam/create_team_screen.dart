import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/createteam/controller/create_team_controller.dart';

class CreateTeamScreen extends GetView<CreateTeamController> {
  const CreateTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Create New Team',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: true,
      isBackIcon: true,
      isCloseBackIcon: true,
      scaffoldKey: controller.scaffoldKeyCreateTeam,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Text(
                  'Join or Create New Team',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: const BoxDecoration(
                    color: kLightGreenContainerColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(kInfoIcon),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Join an existing team or create new one.',
              style: AppStyles.greyTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(kTeamProfileRoute);
              },
              child: Container(
                width: 390.w,
                height: 104.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  shadows: [
                    BoxShadow(
                      color: kBoxShadowColor,
                      blurRadius: 10.r,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                  child: Row(
                    children: [
                      Column(
                        children: [Image.asset(kNewTeamIcon)],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create New Team',
                            style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Create a new team and start inventory \nmanagement for your store more precisely.',
                            style: AppStyles.greyTextStyle().copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: (){
                _showCodeModal(context);
              },
              child: Container(
                width: 390.w,
                height: 104.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  shadows: [
                    BoxShadow(
                      color: kBoxShadowColor,
                      blurRadius: 10.r,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                  child: Row(
                    children: [
                      Column(
                        children: [Image.asset(kJoinTeamIcon)],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Join a Team',
                            style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Join an existing team through invitation\ncode.',
                            style: AppStyles.greyTextStyle().copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 250.h,
            ),
          ],
        ),
      ),
    );
  }

  void _showCodeModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Join Team Through Code',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  'Enter team code',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: TextField(
                        controller: controller.code,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel', style: TextStyle(fontSize: 18.0)),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          controller.joinTeam();
                        },
                        child: const Text('OK', style: TextStyle(fontSize: 16.0)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
