import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_search_bar.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Items/controller/items_controller.dart';

import '../../../../models/items_model.dart';

class ItemsScreen extends GetView<ItemsController> {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showFilterModalBottomSheet(context);
                  },
                  child: Container(
                    width: 45.w,
                    height: 35.h,
                    decoration: ShapeDecoration(
                      color: kLightGreenContainerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Icon(
                      Icons.filter_alt,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    _showSortModalBottomSheet(context);
                  },
                  child: Container(
                    width: 45.w,
                    height: 35.h,
                    decoration: ShapeDecoration(
                      color: kLightGreenContainerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Icon(
                      Icons.compare_arrows_outlined,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
              ],
            )
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final searchQuery = controller.search.value.toLowerCase();
          final filteredItems = controller.items.where((item) {
            return searchQuery.isEmpty ||
                item.name.toLowerCase().contains(searchQuery);
          }).toList();

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  CustomSearchBar(
                    hintText: 'Search Item Here',
                    onChanged: (query) {
                      print('Search query: $query');
                      controller.search.value = query;
                    },
                    onClear: () {
                      print('Search cleared');
                      controller.search.value = '';
                      controller.fetchItems();
                    },
                  ),
                  SizedBox(height: 25.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(kEditItemsRoute, arguments: item);
                        },
                        child: Obx(
                          () => Container(
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
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                            child: CircularProgressIndicator());
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(kRegisterNewItemsRoute);
          },
          backgroundColor: kPrimaryColor,
          shape: const CircleBorder(),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40.sp,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  List<Widget> interleaveAttributesWithSeparator(
      List<Map<String, String>> attributes, String separator) {
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
            if (GetStorage().read('currency') == null )
              Text(
                'Cost: ${item.cost}',
                style: AppStyles.greyTextStyle(),
              ),
            SizedBox(height: 5.h),
            if (GetStorage().read('currency') != null)
              Text(
                'Price: ${item.price} ${GetStorage().read('currency')}',
                style: AppStyles.greyTextStyle(),
              ),
            if (GetStorage().read('currency') == null )
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
            if (GetStorage().read('currency') != null )
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
            if (GetStorage().read('currency') != null)
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

  void _showSortModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Sort',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 2.h,
                width: 400.w,
                color: kGreyButtonColor,
              ),
              SizedBox(height: 20.h),
              _buildSortOption('A to Z', 0),
              _buildSortOption('Z to A', 1),
              _buildSortOption('High to Low', 2),
              _buildSortOption('Low to High', 3),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String text, int index) {
    return Obx(() {
      return ListTile(
        title: Text(
          text,
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Radio(
          value: index,
          groupValue: controller.selectedSortOption.value,
          activeColor: kGreenButtonColor,
          onChanged: (int? value) {
            controller.selectedSortOption.value = value!;
            controller.sortItems();
            Get.back();
          },
        ),
      );
    });
  }

  void showFilterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Filters',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 2.h,
                  width: 400.w,
                  color: kGreyButtonColor,
                ),
                SizedBox(height: 20.h),
                _buildFilterOption('All', 0),
                _buildFilterOption('Item Name', 1),
                _buildFilterOption('Cost', 2),
                _buildFilterOption('Price', 3),
                _buildFilterOption('Type', 5),
                _buildFilterOption('Brand', 6),
                _buildFilterOption('Manufacturer', 7),
                _buildFilterOption('Color', 8),
                _buildFilterOption('Size', 9),
                _buildFilterOption('Storage', 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String text, int index) {
    return Obx(() {
      final controller = Get.find<ItemsController>();
      return ListTile(
        title: Text(
          text,
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Radio(
          value: index,
          groupValue: controller.selectedFilterOption.value,
          activeColor: kGreenButtonColor,
          onChanged: (int? value) {
            controller.selectedFilterOption.value = value!;
            Get.back();
          },
        ),
      );
    });
  }
}
