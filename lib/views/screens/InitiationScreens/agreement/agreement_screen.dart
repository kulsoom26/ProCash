import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/agreement/controller/agreement_screen_controller.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AgreementController controller = Get.put(AgreementController());

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Agreement',
                            style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            width: 390.w,
                            height: 287.h,
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
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 24.h,
                                ),
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                          value: controller.isChecked1.value,
                                          onChanged: (value) {
                                            controller.toggleCheckbox1();
                                          },
                                          activeColor: kGreenButtonColor,
                                          checkColor: Colors.white,
                                        )),
                                    Text(
                                      'I agree to the terms and conditions',
                                      style: AppStyles.greyTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Container(
                                  width: 390.w,
                                  height: 2.h,
                                  decoration: const BoxDecoration(
                                      color: kGreyButtonColor),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                          value: controller.isChecked2.value,
                                          onChanged: (value) {
                                            controller.toggleCheckbox2();
                                          },
                                          activeColor: kGreenButtonColor,
                                          checkColor: Colors.white,
                                        )),
                                    Text(
                                      'I am 14-years or over. ',
                                      style: AppStyles.greyTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '(Required)',
                                      style: AppStyles.redTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                          value: controller.isChecked3.value,
                                          onChanged: (value) {
                                            controller.toggleCheckbox3();
                                          },
                                          activeColor: kGreenButtonColor,
                                          checkColor: Colors.white,
                                        )),
                                    Text(
                                      'Privacy policy. ',
                                      style: AppStyles.greyTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '(Required)',
                                      style: AppStyles.redTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                          value: controller.isChecked4.value,
                                          onChanged: (value) {
                                            controller.toggleCheckbox4();
                                          },
                                          activeColor: kGreenButtonColor,
                                          checkColor: Colors.white,
                                        )),
                                    Text(
                                      'Terms of services. ',
                                      style: AppStyles.greyTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '(Required)',
                                      style: AppStyles.redTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 270.h,
                          ),
                          Center(
                            child: Obx(
                              ()=> controller.isLoading.isTrue? const CircularProgressIndicator(color: kGreenButtonColor,) : CustomButton(
                                width: 390.w,
                                height: 58.h,
                                color: kGreenButtonColor,
                                borderRadius: 10.r,
                                text: 'Create Team',
                                textStyle: AppStyles.whiteTextStyle().copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                onPressed: () {
                                  if(controller.isChecked1.isFalse || controller.isChecked2.isFalse || controller.isChecked3.isFalse || controller.isChecked4.isFalse){
                                    Get.snackbar('Error', 'Please agree to our terms and condition to proceed further');
                                  }
                                  else{
                                    controller.isLoading.value = true;
                                    controller.createTeam();
                                  }
                                  
                                },
                              ),
                            ),
                          ),
                        ])))));
  }
}
