import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_textfield.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';
import '../../../utils/app_styles.dart';

class AddNewRoleScreen extends GetView<SettingsController> {
  const AddNewRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: controller.scaffoldKeyAddNewRole,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: Get.width,
              height: 59.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: kPrimaryColor,
              ),
              child: Center(
                child: Text(
                  'Done',
                  style: AppStyles.whiteTextStyle()
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            'New Member Role',
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: kBlackTextColor,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: kDividerColor,
              height: 1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomTextField1(
                  label: 'Role Name',
                  hint: 'Manager',
                  controller: controller.roleName,
                  isEditable: false,
                ),
              ),
              SizedBox(height: 20.h),
              Divider(color: kDividerColor),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Container(
                        height: 55.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: kDividerColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: Color(0xFF7DEF00),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            SizedBox(
                              width: Get.width,
                              height: 55.h,
                              child: Center(child: Text("Feature Access")),
                            ),
                            Container(
                              width: Get.width,
                              height: 55.h,
                              child:
                                  Center(child: Text("Item Attribute Access")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            FeatureAccessTab(controller: controller),
                            ItemAttributeAccessTab(
                              controller: controller,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureAccessTab extends StatelessWidget {
  const FeatureAccessTab({super.key, required this.controller});
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        itemCount: controller.featureAccess.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 5.h,
        ),
        itemBuilder: (context, index) {
          return Obx(() => buildListItem(
              controller.featureAccess[index]['name'],
              controller.featureAccess[index]['active']));
        },
      );
    });
  }

 Widget buildListItem(String title, RxBool active) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppStyles.blackTextStyle().copyWith(fontSize: 16.sp),
      ),
      Obx(() => CupertinoSwitch(
        activeColor: kPrimaryColor,
        
        value: active.value,
        onChanged: (bool value) {
          active.value = value;
        },
      )),
    ],
  );
}
}

class ItemAttributeAccessTab extends StatelessWidget {
  final SettingsController controller;

  const ItemAttributeAccessTab({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        itemCount: controller.itemAttributeAccess.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 5.h,
        ),
        itemBuilder: (context, index) {
          return Obx(() => buildListItem(
              controller.itemAttributeAccess[index]['name'],
              controller.itemAttributeAccess[index]['active']));
        },
      );
    });
  }

  Widget buildListItem(String title, RxBool active) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppStyles.blackTextStyle().copyWith(fontSize: 16.sp),
      ),
      Obx(() => CupertinoSwitch(
        activeColor: kPrimaryColor,
        
        value: active.value,
        onChanged: (bool value) {
          active.value = value;
        },
      )),
    ],
  );
}
}
