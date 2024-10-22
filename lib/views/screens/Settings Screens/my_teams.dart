import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

class MyTeamsScreen extends GetView<SettingsController> {
  const MyTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Select Team',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: false,
      isBackIcon: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(kCreateTeamRoute);
            },
            child: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: kPrimaryColor.withOpacity(0.2),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
      scaffoldKey: controller.scaffoldKeyMyTeams,
      body: SingleChildScrollView(
        child: Obx(() {
          return Wrap(
            spacing: 10.h,
            runSpacing: 10.h,
            children: controller.teams.map((team) {
              final imageUrl = team['image'] ?? '';
              final mode = team['mode'] ?? 'N/A';
              final name = team['name'] ?? 'No Name';
              final totalItems = team['totalItems'] ?? 0;
              final totalMembers = team['totalMembers'] ?? 0;
              final totalLocations = team['totalLocations'] ?? 0;
              final description = team['description'] ?? 'No Description';

              return Container(
                width: Get.width * 0.9, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: kGreyTextColor, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.network(
                              imageUrl,
                              width: 150.w,
                              height: 150.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Image.asset(
                                      kPackagesIcon,
                                      width: 23.w,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      '$totalItems',
                                      style: AppStyles.greyTextStyle()
                                          .copyWith(color: kBlackButtonColor),
                                    ),
                                    SizedBox(width: 10.w),
                                    Image.asset(
                                      kMembersIcon,
                                      width: 20.w,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      '$totalMembers',
                                      style: AppStyles.greyTextStyle()
                                          .copyWith(color: kBlackButtonColor),
                                    ),
                                    SizedBox(width: 10.w),
                                    Image.asset(
                                      kLocationIcon,
                                      width: 17.w,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      '$totalLocations',
                                      style: AppStyles.greyTextStyle()
                                          .copyWith(color: kBlackButtonColor),
                                    ),
                                    SizedBox(width: 10.w),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  description,
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  style: AppStyles.greyTextStyle()
                                      .copyWith(color: kBlackButtonColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          controller.changeTeam(team['id'], team['mode'], team['adminId']);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: kDisableButtonColor),
                          child: Center(
                            child: Text(
                              'Select',
                              style: AppStyles.greenTextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
