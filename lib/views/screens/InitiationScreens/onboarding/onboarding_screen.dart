import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_button.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/onboarding/controller/onboarding_controller.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [kImage1, kImage2, kImage3, kImage4];
    final List<String> texts = [
      'Maximize efficiency\nwith inventory analysis.',
      'Quick transactions in no\ntime with barcode facility.',
      'Add multiple items in multiple\nwarehouses at one place.',
      'Add members, create a\nteam to work together.'
    ];

    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: '',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isBackIcon: false,
      isCloseBackIcon: false,
      scaffoldKey: controller.scaffoldKeyOnBoarding,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpandableCarousel(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  controller.updateIndex(index);
                },
                viewportFraction: 1.0,
                height: 295.h,
              ),
              items: images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 375.w,
                      height: 295.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 120.h),
            Obx(() {
              return Text(
                texts[controller.currentIndex.value],
                textAlign: TextAlign.center,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
            SizedBox(height: 20.h),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return Container(
                    width: 8.w,
                    height: 8.h,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentIndex.value == index
                          ? kGreenButtonColor
                          : kLightGreenContainerColor,
                    ),
                  );
                }),
              );
            }),
            SizedBox(height: 80.h),
            CustomButton(
              width: 390.w,
              height: 58.h,
              color: kGreenButtonColor,
              borderRadius: 10.r,
              text: 'Start',
              textStyle: AppStyles.whiteTextStyle().copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              onPressed: () {
                Get.toNamed(kProfileRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
