import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_search_bar.dart';

class LocationScreen extends GetView<SettingsController> {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Locations',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyLocations,
      floatingActionButton: GestureDetector(
        onTap: (){
          Get.toNamed(kSettingsLocationAddRoute);
          
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kPrimaryColor,
            radius: 25,
            child: Center(
              child: Icon(
                Icons.add,
                color: kWhiteButtonColor,
                size: 30,
              ),
            ),
          ),
        ),
      ),
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
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: Obx(() {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.locations.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    var data = controller.locations[index];
                    return Container(
                      width: Get.width,
                      height: 70.h,
                      decoration: BoxDecoration(
                          color: kGreyContainerColor,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: GestureDetector(
                          onTap: (){
                            
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: kPrimaryColor.withOpacity(0.3),
                                child: Image.asset(
                                data['image'],
                                width: 30.w,
                              ),
                              ),
                              
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                data['name'],
                                style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 17.sp, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              
                              GestureDetector(
                                onTap: (){
                                  _showDeleteConfirmationModal(context, data['name'], controller, index);
                                },
                                child: const Icon(Icons.delete, color: kRedButtonColor, size: 25,)),

                              
                            ],
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
  void _showDeleteConfirmationModal(
      BuildContext context, String data, SettingsController controller, int index) {

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
                  backgroundColor: kRedTextColor,
                  radius: 25,
                  child: Center(
                    child:
                        Icon(Icons.delete, size: 30.w, color: kWhiteTextColor),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Delete Attribute!',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: kRedTextColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Really Delete "$data" Attribute?',
                  textAlign: TextAlign.center,
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 15.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 20.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        Get.close(1);
                      },
                      child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 20.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        controller.deleteLocation(data);
                        Get.back();
                      },
                      child: Text('Delete', style: TextStyle(fontSize: 16.sp)),
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
