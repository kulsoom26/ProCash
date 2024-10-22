import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/AddMembers/controller/add_member_controller.dart';

class AddMembersScreen extends GetView<AddMemberController> {
  const AddMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Members',
      centerTitle: false,
      isFullBody: false,
      actions: [
        GestureDetector(
          onTap: () {
            String message = '''
              [Let's manage inventory together!]

              You have been invited to ProCash-Food, an inventory management app.

              Join the team and collectively manage all items together.

              * Invite code: ${controller.teamCode}

              Start using Procash now!''';
            Share.share(message);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 25.w),
            child: Container(
              width: 82.w,
              height: 28.h,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [kGradient1Color, kGradient2Color],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Center(
                child: Text(
                  'Invite',
                  style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyAddMember,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 376.w,
              height: 680.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2.w,
                    color: Colors.white.withOpacity(0.20000000298023224),
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    'Share with friends',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Image.asset(kDoodle),
                  SizedBox(height: 30.h),
                  Text(
                    'Want to invite others to join this group.',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(height: 30.h),
                  Text(
                    'OR',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(kFacebook1Icon),
                        Image.asset(kInstagramIcon),
                        Image.asset(kLinkedinIcon),
                        Image.asset(kTwitterIcon),
                        Image.asset(kWhatsappIcon),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  GestureDetector(
                     onTap: () {
            String message = '''
              [Let's manage inventory together!]

              You have been invited to ProCash-Food, an inventory management app.

              Join the team and collectively manage all items together.

              * Invite code: ${controller.teamCode}

              Start using Procash now!''';
            Share.share(message);
          },
                    child: Container(
                      width: 346.w,
                      height: 65.h,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [kGradient1Color, kGradient2Color],
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2.w,
                            color: Colors.white.withOpacity(0.6000000238418579),
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Share Invite Link',
                          style: AppStyles.whiteTextStyle().copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Text(
                          'Skip',
                          style: AppStyles.whiteTextStyle().copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: kGreenButtonColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
