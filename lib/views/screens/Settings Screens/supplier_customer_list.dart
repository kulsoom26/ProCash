import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_search_bar.dart';

class SupplierCustomerScreen extends GetView<SettingsController> {
  const SupplierCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String title = arguments['title'];
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: title,
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeySupplierCustomerList,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(
            kSettingsCustomerSupplierAddRoute,
            arguments: {'title': title == 'Supplier' ? 'Add Supplier' : 'Add Customer'},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
            SizedBox(height: 10.h),
            Container(
              width: Get.width,
              height: Get.height,
              child: Obx(() {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: title == 'Supplier'
                      ? controller.suppliersList.length
                      : controller.customersList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    var data;
                    if (title == 'Supplier') {
                      data = controller.suppliersList[index];
                    } else {
                      data = controller.customersList[index];
                    }

                    
                    return Container(
                      width: Get.width,
                      height: 70.h,
                      decoration: BoxDecoration(
                          color: kGreyContainerColor,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              kSettingsCustomerSupplierEditRoute,
                              arguments: {
                                'title': title == 'Supplier' ? 'Supplier Information' : 'Customer Information',
                                'name': data.name,
                                'id':data.id,
                                'email': data.email,
                                'telephone': data.telephone,
                                'address': data.address,
                                'description': data.description
                              },
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10.w),
                              Text(
                                data.name, 
                                style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 17.sp, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              GestureDetector(
                          onTap: () {
                            _showEditModal(context,data.id, data.name, title);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: kBlackTextColor,
                          ),
                        ),
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

  void _showEditModal(BuildContext context, String data, String name, String title) {
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
                            _showDeleteConfirmationModal(context, data, name, title);
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
      BuildContext context, String data, String name, String title) {
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
                          if(title == 'Supplier'){
                            controller.deleteSupplier(data,name);
                          } else {
                            controller.deleteCustomer(data,name);
                          }
                          

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
