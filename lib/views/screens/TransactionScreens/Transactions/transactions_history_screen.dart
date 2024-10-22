import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/Transactions/controller/transaction_history_controller.dart';

import '../../../../models/stocks.dart';
import '../../../../utils/app_images.dart';

class TransactionHistoryScreen extends GetView<TransactionHistoryController> {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Transactions',
        centerTitle: true,
        isFullBody: false,
        showAppBarBackButton: false,
        isBackIcon: false,
        isCloseBackIcon: false,
        actions: [
          Row(
            children: [
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
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: const Icon(
                    Icons.filter_alt,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          )
        ],
        scaffoldKey: controller.scaffoldKeyTransaction,
        body: Obx(() {
          if (controller.groupedTransactions.isEmpty) {
            return const Center(child: Text('No transactions available'));
          }
          return ListView.builder(
            itemCount: controller.groupedTransactions.length,
            itemBuilder: (context, index) {
              final date = controller.groupedTransactions.keys.toList()[index];
              final transactions = controller.groupedTransactions[date];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Container(
                    width: 115.w,
                    height: 31.h,
                    decoration: ShapeDecoration(
                      color: kLightGreyColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Center(
                      child: Text(
                        date,
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions?.length ?? 0,
                    itemBuilder: (context, index) {
                      final transaction = transactions![index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: TransactionTile(transaction: transaction),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
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
                  'Filter',
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
              _buildSortOption('All', 0),
              _buildSortOption('Stock In', 1),
              _buildSortOption('Stock Out', 2),
              _buildSortOption('Adjust', 3),
              _buildSortOption('Move', 4),
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
            controller.filterTransactions();
            Get.back();
          },
        ),
      );
    });
  }
}

class TransactionTile extends StatelessWidget {
  final Stock transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 154.h,
      decoration: ShapeDecoration(
        color: kGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, top: 15.h, right: 20.w),
        child: Row(
          children: [
            Column(
              children: [
                if (transaction.type == 'Stock In') Image.asset(kInIcon),
                if (transaction.type == 'Stock Out') Image.asset(kOutIcon),
                if (transaction.type == 'Adjust') Image.asset(kAdjustIcon),
                if (transaction.type == 'Move') Image.asset(kMoveIcon)
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.type,
                  style: AppStyles.redTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: transaction.type == 'Stock In'
                        ? kRedTextColor
                        : transaction.type == 'Stock Out'
                            ? kStock2TextColor
                            : transaction.type == 'Adjust'
                                ? kStock3TextColor
                                : kStock4TextColor,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                if (GetStorage().read('mode') == 'Location Mode')
                  Text(
                    transaction.location!,
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(
                  height: 5.h,
                ),
                if (transaction.note != '')
                  Text(
                    transaction.note!,
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  transaction.userName,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  transaction.itemName,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Image.network(
                    transaction.image,
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  '${transaction.quantity}',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
