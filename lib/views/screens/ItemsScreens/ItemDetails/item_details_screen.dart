import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_search_bar.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/ItemDetails/controller/item_details_controller.dart';

import '../../../../models/items_model.dart';
import '../Items/controller/items_controller.dart';

class ItemDetailsScreen extends GetView<ItemDetailsController> {
  const ItemDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Item item = Get.arguments;
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Details',
        centerTitle: false,
        isFullBody: false,
        showAppBarBackButton: false,
        isCloseBackIcon: false,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeyItemDetails,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              // CustomSearchBar(
              //   hintText: 'Search Location Here',
              //   onChanged: (query) {
              //     print('Search query: $query');
              //   },
              //   onClear: () {
              //     print('Search cleared');
              //   },
              // ),
              SizedBox(height: 20.h),
              Container(
                            width: 390.w,
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: ShapeDecoration(
                              color: kGreyColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.w),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      item.image,
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.error);
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(child: CircularProgressIndicator());
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15.w),
                                  Expanded(
                                    child: _buildItemContent(item),
                                  ),
                                ],
                              ),
                            ),
                          ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    'Inventory Level',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  
                ],
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 250.h,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 0),
                          const FlSpot(1, 1),
                          const FlSpot(2, 1.5),
                          const FlSpot(3, 1.4),
                          const FlSpot(4, 3),
                          const FlSpot(5, 2.8),
                          const FlSpot(6, 2.5),
                          const FlSpot(7, 2),
                          const FlSpot(8, 1.8),
                          const FlSpot(9, 1),
                          const FlSpot(10, 0.5),
                          const FlSpot(11, 0),
                        ],
                        isCurved: true,
                        color: kPrimaryColor,
                        barWidth: 4,
                        belowBarData: BarAreaData(
                          show: true,
                          color: kPrimaryColor.withOpacity(0.3),
                        ),
                      ),
                    ],
                    titlesData: const FlTitlesData(
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      bottomTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: true)),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black),
                    ),
                    gridData: const FlGridData(show: true),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> interleaveAttributesWithSeparator(List<Map<String, String>> attributes, String separator) {
    List<Widget> interleavedList = [];
    for (int i = 0; i < attributes.length; i++) {
      interleavedList.add(Text(
        attributes[i]['value']!,
        style: AppStyles.greyTextStyle(),
      ));
      if (i < attributes.length - 1) {
        interleavedList.add(Text(
          separator,
          style: AppStyles.greyTextStyle(),
        ));
      }
    }
    return interleavedList;
  }

  Widget _buildItemContent(Item item) {
    final controller = Get.find<ItemsController>();

    switch (controller.selectedFilterOption.value) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${item.quantity}',
                  style: AppStyles.greenTextStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            if (GetStorage().read('currency') != null)
              Text(
                'Cost: ${item.cost} ${GetStorage().read('currency')}',
                style: AppStyles.greyTextStyle(),
              ),
            if (GetStorage().read('currency') == null)
              Text(
                'Cost: ${item.cost}',
                style: AppStyles.greyTextStyle(),
              ),
            SizedBox(height: 5.h),
            if (GetStorage().read('currency') != null )
              Text(
                'Price: ${item.price} ${GetStorage().read('currency')}',
                style: AppStyles.greyTextStyle(),
              ),
            if (GetStorage().read('currency') == null)
              Text(
                'Price: ${item.price}',
                style: AppStyles.greyTextStyle(),
              ),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 5.w,
              runSpacing: 5.h,
              children: interleaveAttributesWithSeparator(item.attributes, "|"),
            ),
          ],
        );
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${item.quantity}',
              style: AppStyles.greenTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${item.quantity}',
                  style: AppStyles.greenTextStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            if (GetStorage().read('currency') != null)
              Text(
                'Cost: ${item.cost} ${GetStorage().read('currency')}',
                style: AppStyles.greyTextStyle(),
              ),
            if (GetStorage().read('currency') == null )
              Text(
                'Cost: ${item.cost}',
                style: AppStyles.greyTextStyle(),
              ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${item.quantity}',
                  style: AppStyles.greenTextStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            if (GetStorage().read('currency') != null )
              Text(
                'Price: ${item.price} ${GetStorage().read('currency')}',
                style: AppStyles.greyTextStyle(),
              ),
            if (GetStorage().read('currency') == null )
              Text(
                'Price: ${item.price}',
                style: AppStyles.greyTextStyle(),
              ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${item.quantity}',
                  style: AppStyles.greenTextStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 5.w,
              runSpacing: 5.h,
              children: interleaveAttributesWithSeparator(item.attributes, "|"),
            ),
          ],
        );
    }
  }
}
