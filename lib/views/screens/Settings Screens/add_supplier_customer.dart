import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/models/customers_model.dart';
import 'package:pro_cash_food/models/suppliers_model.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_textfield.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class AddSupplierCustomerScreen extends GetView<SettingsController> {
  const AddSupplierCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String title = arguments['title'];
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: '',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyAddSupplierCustomer,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        child: GestureDetector(
          onTap: () {
            if(title == 'Add Supplier'){
               var newSupplier = Supplier(
              name: controller.nameAdd.text.trim(),
              teamId: GetStorage().read('teamId'),
              email: controller.emailAdd.text.trim(),
              telephone: controller.telephoneAdd.text.trim(),
              address: controller.addressAdd.text.trim(),
              description: controller.descriptionAdd.text.trim()
              );
              controller.addSupplier(newSupplier);
            } else {
              var newCustomer = Customer(
              name: controller.nameAdd.text.trim(),
              teamId: GetStorage().read('teamId'),
              email: controller.emailAdd.text.trim(),
              telephone: controller.telephoneAdd.text.trim(),
              address: controller.addressAdd.text.trim(),
              description: controller.descriptionAdd.text.trim()
              );
              controller.addCustomer(newCustomer);
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
              Text(
                title,
                style: AppStyles.blackTextStyle()
                    .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomTextField1(
                  label: 'Name:',
                  hint: "Enter Name",
                  controller: controller.nameAdd,
                  isEditable: false),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField1(
                  label: 'Telephone:',
                  hint: "Enter Telephone",
                  controller: controller.telephoneAdd,
                  isEditable: false),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField1(
                  label: 'Email:',
                  hint: "Enter Email",
                  controller: controller.emailAdd,
                  isEditable: false),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField1(
                  label: 'Address:',
                  hint: "Enter Address",
                  controller: controller.addressAdd,
                  isEditable: false),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField1(
                  label: 'Description:',
                  hint: "Enter Description",
                  controller: controller.descriptionAdd,
                  isEditable: false),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
