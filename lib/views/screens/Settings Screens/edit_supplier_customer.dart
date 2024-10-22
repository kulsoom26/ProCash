import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/models/customers_model.dart';
import 'package:pro_cash_food/models/suppliers_model.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class EditSupplierCustomerScreen extends GetView<SettingsController> {
  const EditSupplierCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String title = arguments['title'];
    final String id = arguments['id'];
    final String name = arguments['name'];
    final String email = arguments['email'];
    final String telephone = arguments['telephone'];
    final String address = arguments['address'];
    final String description = arguments['description'];
    controller.name.text = name;
    controller.email.text = email;
    controller.telephone.text = telephone;
    controller.address.text = address;
    controller.description.text = description;
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: '',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyEditSupplierCustomer,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        child: GestureDetector(
          onTap: () {
            if(title == 'Supplier Information'){
               var newSupplier = Supplier(
              name: controller.name.text.trim(),
              teamId: GetStorage().read('teamId'),
              email: controller.email.text.trim(),
              telephone: controller.telephone.text.trim(),
              address: controller.address.text.trim(),
              description: controller.description.text.trim()
              );
              controller.updateSupplier(id,newSupplier);
            } else {
              var newCustomer = Customer(
              name: controller.name.text.trim(),
              teamId: GetStorage().read('teamId'),
              email: controller.email.text.trim(),
              telephone: controller.telephone.text.trim(),
              address: controller.address.text.trim(),
              description: controller.description.text.trim()
              );
              controller.updateCustomer(id,newCustomer);
            }
           controller.nameAdd.text='';
             controller.emailAdd.text='';
             controller.telephoneAdd.text='';
              controller.addressAdd.text='';
              controller.descriptionAdd.text='';
            Get.back();
          },
          child: Container(
            width: Get.width,
            height: 59.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: kGreyButtonColor,
            ),
            child: Center(
              child: Text(
                'Save',
                style: AppStyles.whiteTextStyle()
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppStyles.blackTextStyle()
                        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDeleteConfirmationModal(context, name);
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: kRedButtonColor.withOpacity(0.3)),
                      child: const Center(
                        child: Icon(
                          Icons.delete,
                          color: kRedButtonColor,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Name',
                style: AppStyles.greyTextStyle()
                    .copyWith(color: kLabelColor, fontSize: 15.sp),
              ),
              TextField(
                  controller: controller.name,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kLabelColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  style: AppStyles.blackTextStyle()
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h,),
                  Text(
                'Telephone',
                style: AppStyles.greyTextStyle()
                    .copyWith(color: kLabelColor, fontSize: 15.sp),
              ),
              TextField(
                  controller: controller.telephone,
                  decoration: const InputDecoration(
                    hintText: 'Telephone',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kLabelColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  style: AppStyles.blackTextStyle()
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10,),
                      Text(
                'Email',
                style: AppStyles.greyTextStyle()
                    .copyWith(color: kLabelColor, fontSize: 15.sp),
              ),
              TextField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kLabelColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  style: AppStyles.blackTextStyle()
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10,),
                      Text(
                'Address',
                style: AppStyles.greyTextStyle()
                    .copyWith(color: kLabelColor, fontSize: 15.sp),
              ),
              TextField(
                  controller: controller.address,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kLabelColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  style: AppStyles.blackTextStyle()
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10,),
                      Text(
                'Description',
                style: AppStyles.greyTextStyle()
                    .copyWith(color: kLabelColor, fontSize: 15.sp),
              ),
              TextField(
                  controller: controller.description,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kLabelColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  style: AppStyles.blackTextStyle()
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
  void _showDeleteConfirmationModal(
      BuildContext context, String data) {
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
                        Get.close(2);
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
