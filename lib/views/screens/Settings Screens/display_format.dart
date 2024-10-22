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

class DisplayFormatScreen extends GetView<SettingsController> {
  const DisplayFormatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Display Format',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyDisplayFormat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 260.h,
              child: Obx(() {
                    return ListView.separated(
                      itemCount: controller.displayFormat.length,
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemBuilder: (context, index) {
                        return Obx(
                          () => RadioListTile<String>(
                            activeColor: kPrimaryColor,
                            title: Text(
                              controller.displayFormat[index],
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 15.sp,
                              ),
                            ),
                            value: controller.displayFormat[index],
                            groupValue: controller.format.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.format.value = value;
                              }
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        );
                      },
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    width: Get.width*0.4,
                    height: 58.h,
                    decoration: BoxDecoration(
                      color: kGrayButtonColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text("Cancel", style: AppStyles.whiteTextStyle(),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    width: Get.width*0.4,
                    height: 58.h,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text("Save", style: AppStyles.whiteTextStyle(),),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
