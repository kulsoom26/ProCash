import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/AdminScreens/AdminRequests/controller/admin_requests_controller.dart';

class AdminRequestScreen extends GetView<AdminRequestController> {
  const AdminRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: 'Join Requests',
        centerTitle: false,
        isFullBody: false,
        showAppBarBackButton: true,
        isBackIcon: true,
        isCloseBackIcon: false,
        scaffoldKey: controller.scaffoldKeyAdminRequest,
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.requests.isEmpty) {
            return Center(
              child: Text('No new requests'),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(
                    height: 25.h,
                  ),
                  Obx(() => controller.requests.length == 0 ? Center(child: Text('No new requests found!', style: AppStyles.blackTextStyle(),),): 
                  
                  
                  Column(
                    children: controller.requests.map((request) {
                      return Container(
                        width: 390.w,
                        height: 149.h,
                        margin: EdgeInsets.only(bottom: 10.h),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          shadows: [
                            BoxShadow(
                              color: kBoxShadowColor,
                              blurRadius: 10.r,
                              offset: const Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, top: 5.h, right: 20.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      if (request.image == '')
                                        Image.asset(
                                          kProfileImage,
                                          height: 70.h,
                                          width: 70.w,
                                        ),
                                      if (request.image != '')
                                        Image.network(
                                          request.image,
                                          height: 70.h,
                                          width: 70.w,
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        request.name,
                                        style:
                                            AppStyles.blackTextStyle().copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        request.email,
                                        style:
                                            AppStyles.blackTextStyle().copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      width: 157.w,
                                      height: 45.h,
                                      color: kGreyButtonColor,
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
                                        controller.acceptRequest(request);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
