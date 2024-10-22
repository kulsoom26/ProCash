import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';
import '../../custom_widgets/custom_search_bar.dart';

class CurrencyScreen extends GetView<SettingsController> {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Currency',
      centerTitle: false,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyCurrency,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            CustomSearchBar(
              hintText: 'Search Here...',
              onChanged: (query) {
                print('Search query: $query');
              },
              onClear: () {
                print('Search cleared');
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: Get.width,
                height: Get.height * 0.71,
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
                child: Obx(() {
                  return ListView.separated(
                    itemCount: controller.currency.length,
                    separatorBuilder: (context, index) => Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    itemBuilder: (context, index) {
                      String currencyName = controller.currency[index]['name'];
                      return Obx(
                        () => ListTile(
                          leading: Image.asset(
                            controller.currency[index]['image'],
                            width: 30.w,
                            height: 30.h,
                          ),
                          title: Text(
                            currencyName,
                            style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 15.sp,
                            ),
                          ),
                          trailing: controller.selectedCurrency.value == currencyName
                              ? Icon(
                                  Icons.check,
                                  color: kPrimaryColor,
                                )
                              : null,
                          onTap: () {
                            controller.selectedCurrency.value = currencyName;
                            GetStorage().write('currency', controller.currency[index]['symbol']);
                            print(GetStorage().read('currency'));
                            print('Selected: $currencyName');
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
