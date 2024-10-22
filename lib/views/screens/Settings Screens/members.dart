import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';
import '../../custom_widgets/custom_search_bar.dart';

class MembersScreen extends GetView<SettingsController> {
  const MembersScreen({super.key});

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
      scaffoldKey: controller.scaffoldKeyMembers,
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(kSettingsMemberInviteRoute);
          },
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
                child: Text('Invite', style: AppStyles.whiteTextStyle().copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp
                ),),
              ),
            ),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              hintText: 'Search Here...',
              onChanged: (query) {
                print('Search query: $query');
              },
              onClear: () {
                print('Search cleared');
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.71,
              child: Obx(() {
                return ListView.separated(
                  itemCount: controller.existingMembers.length,
                  separatorBuilder: (context, index) => Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => ListTile(
                        leading: Image.network(
                          controller.existingMembers[index]['image'],
                          width: 40.w,
                          height: 40.h,
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.existingMembers[index]['name'],
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              controller.existingMembers[index]['email'],
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            _showEditModal(context, controller.existingMembers[index]['id'], );
                          },
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: kBlackTextColor,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditModal(BuildContext context, String data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                    
                      ListTile(
                        title: Center(
                            child: Text('Delete',
                                style: AppStyles.blackTextStyle())),
                        onTap: () {
                          Navigator.pop(context);
                          if(GetStorage().read('id') == GetStorage().read('adminId')){
                            _showDeleteConfirmationModal(context, data);
                          } else {
                            Get.snackbar('Sorry!!', 'Sorry, only admin can remove member');
                          }
                          
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel', style: TextStyle(fontSize: 18.sp)),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationModal(
      BuildContext context, String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: kPrimaryColor.withOpacity(0.3),
                  radius: 25,
                  child: Center(
                    child: Text(
                      'i',
                      style: AppStyles.greenTextStyle().copyWith(
                          fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Are you sure?',
                  textAlign: TextAlign.center,
                  style: AppStyles.blackTextStyle()
                      .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controller.deleteMemberFromTeam(data);
                          Get.close(2);
                        },
                        child: Text('Yes', style: TextStyle(fontSize: 16.sp)),
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
