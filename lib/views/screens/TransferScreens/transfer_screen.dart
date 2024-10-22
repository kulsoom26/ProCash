import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/TransferScreens/controller/transfer_screen_controller.dart';

class TransferScreen extends GetView<TransferScreenController> {
  const TransferScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Stock Transfer Requests',
        centerTitle: false,
        isFullBody: false,
        showAppBarBackButton: false,
        isCloseBackIcon: false,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeyTransfer,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Sort:',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Obx(() {
                    return Container(
                      width: 120.w,
                      height: 33.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)),
                        shadows: [
                          BoxShadow(
                            color: kBoxShadowColor,
                            blurRadius: 10.r,
                            offset: const Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: DropdownButton<String>(
                          value: controller.selectedSort.value,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          iconSize: 24,
                          elevation: 0,
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            controller.selectedSort.value = newValue!;
                            controller.filterRequests();
                          },
                          items: controller.sortOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  })
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => controller.filteredRequests.isNotEmpty ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredRequests.length,
                  itemBuilder: (context, index) {
                    final request = controller.filteredRequests[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.h,left: 5.w, right: 5.w),
                      width: 390.w,
                      height: 228.h,
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
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 15.w, right: 20.w, top: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Column(
                                children: [
                                  Image.network(
                                    request.image,
                                    height: 70.h,
                                    width: 70.w,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      request.type,
                                      style:
                                          AppStyles.blackTextStyle().copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          request.location ?? '                     ',
                                          style: AppStyles.greyTextStyle()
                                              .copyWith(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120.w,
                                        ),
                                        Text(
                                          '${request.quantity}',
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                            ]),
                            Padding(
                              padding: EdgeInsets.only(left: 80.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  if (request.type == 'Stock In')
                                    Text(
                                      '${request.note ?? ''} | ${request.supplier ?? ''}',
                                      style:
                                          AppStyles.blackTextStyle().copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  if (request.type == 'Stock Out')
                                    Text(
                                      '${request.note ?? ''} | ${request.customer ?? ''}',
                                      style:
                                          AppStyles.blackTextStyle().copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  if (request.type == 'Adjust')
                                    Text(
                                      request.note ?? '',
                                      style:
                                          AppStyles.blackTextStyle().copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  if (request.type == 'Move')
                                    Text(
                                      '${request.note ?? ''} | ${request.toLocation ?? ''}',
                                      style:
                                          AppStyles.blackTextStyle().copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    request.userName,
                                    style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    request.itemName,
                                    style: AppStyles.blackTextStyle().copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.w, top: 20.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                    width: 157.w,
                                    height: 45.h,
                                    color: kDarkGreyButtonColor,
                                    borderRadius: 10.r,
                                    text: 'Reject',
                                    textStyle:
                                        AppStyles.whiteTextStyle().copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    onPressed: () {
                                      controller.rejectRequest(request);
                                    },
                                  ),
                                  CustomButton(
                                    width: 157.w,
                                    height: 45.h,
                                    color: kGreenButtonColor,
                                    borderRadius: 10.r,
                                    text: 'Accept',
                                    textStyle:
                                        AppStyles.whiteTextStyle().copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    onPressed: () {
                                      if(request.type == 'Stock In'){
                                        controller.acceptRequest(request);
                                      } else if(request.type == 'Stock Out'){
                                        controller.acceptStockOutRequest(request);
                                      } else if(request.type == 'Adjust'){
                                        controller.adjustStock(request);
                                      } else if(request.type == 'Move'){
                                        controller.moveStock(request);
                                      }
                                      
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ): Center(
                  child: Text('No transfer request found!', style: AppStyles.blackTextStyle(),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
