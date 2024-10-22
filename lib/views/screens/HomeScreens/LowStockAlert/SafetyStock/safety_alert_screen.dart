import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import '../../../../../models/items_model.dart';
import '../../../../../utils/app_strings.dart';
import 'controller/safety_stock_controller.dart';

class SafetyAlertScreen extends GetView<SafetyStockController> {
  const SafetyAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Safety Alert',
      centerTitle: false,
      isFullBody: false,
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(kSafetyStockSettingsRoute);
          },
          child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Container(
                width: 45.w,
                height: 35.h,
                decoration: ShapeDecoration(
                  color: kLightGreenContainerColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: const Icon(
                  Icons.settings,
                  color: kGreenButtonColor,
                ),
              )),
        ),
      ],
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeySafetyAlert,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            _buildSectionHeader('Low Stock', Colors.red),
            Obx(() => _buildItemList(
                  controller.items.where((item) => controller.isLowStock(item)).toList(),
                  Colors.red,
                )),
            SizedBox(height: 40.h),
            _buildSectionHeader('Excess Stock', Colors.blue),
            Obx(() => _buildItemList(
                  controller.items.where((item) => !controller.isLowStock(item)).toList(),
                  Colors.blue,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5.r,
          backgroundColor: color,
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildItemList(List<Item> items, Color textColor) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
          ),
          title: Text(
            item.name,
            style: TextStyle(color: textColor),
          ),
          subtitle: _buildLocationDetails(item, textColor),
          trailing: Text(
            controller.getLocationQuantity(item).toString(),
            style: TextStyle(color: textColor),
          ),
        );
      },
    );
  }

  Widget _buildLocationDetails(Item item, Color textColor) {
    if (item.locations == null || item.locations!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: item.locations!
          .map((location) => Text(
                '${location['name']}: ${location['quantity']}',
                style: TextStyle(color: textColor, fontSize: 12.sp),
              ))
          .toList(),
    );
  }
}
