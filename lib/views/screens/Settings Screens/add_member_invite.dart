import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';
import 'package:share/share.dart';

class MembersInviteScreen extends GetView<SettingsController> {
  const MembersInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Members',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyMemberInvite,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Container(
              width: 82.w,
              height: 28.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7DEF00),
                    Color(0xFF509900),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'Invite',
                  style: AppStyles.whiteTextStyle()
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp),
                ),
              ),
            ),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 500.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.50.w, color: kGreyTextColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Share with friends',
                    style: AppStyles.blackTextStyle().copyWith(
                        fontFamily: 'Poppins',
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Image.asset(
                    kInvite,
                    width: 170.w,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Want to invite others to join this group.',
                    style: AppStyles.blackTextStyle()
                        .copyWith(fontFamily: 'Poppins', fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       _buildShareButton(kFacebook1Icon),
                  //       _buildShareButton(kInstagramIcon),
                  //       _buildShareButton(kLinkedinIcon),
                  //       _buildShareButton(kTwitterIcon),
                  //       _buildShareButton(kWhatsappIcon),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: () {
            String message = '''
              [Let's manage inventory together!]

              You have been invited to ProCash-Food, an inventory management app.

              Join the team and collectively manage all items together.

              * Invite code: ${controller.teamCode.value}

              Start using Procash now!''';
            Share.share(message);
          },
                    child: Container(
                      width: 346.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF7DEF00),
                            Color(0xFF509900),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Share invite link',
                          style: AppStyles.whiteTextStyle()
                              .copyWith(fontWeight: FontWeight.w600),
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

  // Helper function to build share buttons
  Widget _buildShareButton(String iconPath) {
    return Container(
      width: 50.w,
      height: 50.h,
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
      child: Center(
        child: Image.asset(
          iconPath,
          width: 40.w,
        ),
      ),
    );
  }

  // Function to show the bottom sheet modal
  void _showShareModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Share via',
                style: AppStyles.blackTextStyle()
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildShareOption(context, kWhatsappIcon, 'WhatsApp'),
                  _buildShareOption(context, kInstagramIcon, 'Instagram'),
                  _buildShareOption(context, kFacebook1Icon, 'Facebook'),
                  _buildShareOption(context, kTwitterIcon, 'Twitter'),
                  _buildShareOption(context, kLinkedinIcon, 'LinkedIn'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper function to build each share option in the modal
  Widget _buildShareOption(BuildContext context, String iconPath, String name) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        print('Sharing via $name');
        // Here you would handle the sharing logic
      },
      child: Column(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
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
            child: Center(
              child: Image.asset(
                iconPath,
                width: 40.w,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            name,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
