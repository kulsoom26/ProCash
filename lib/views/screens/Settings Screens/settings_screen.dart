import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/models/notes_model.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_styles.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_scaffold.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';

import '../../../utils/app_strings.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: 'Settings',
      centerTitle: true,
      isFullBody: false,
      showAppBarBackButton: false,
      isCloseBackIcon: false,
      isBackIcon: false,
      scaffoldKey: controller.scaffoldKeySettings,
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(kSettingsUserProfilingRoute);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: kPrimaryColor.withOpacity(0.3),
              ),
              child: const Center(
                child: Icon(
                  Icons.settings,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
      body: Obx(
        () => controller.teamData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 230.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(controller.teamData[0].image),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 127.w,
                                height: 27.h,
                                decoration: BoxDecoration(
                                    color:
                                        kDarkGreyButtonColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(6.r),
                                        topRight: Radius.circular(4.r))),
                                child: Center(
                                  child: Obx(
                                    () => Text(
                                        controller.teamData.isEmpty
                                            ? 'Basic Mode'
                                            : controller.teamData[0].mode,
                                        style: AppStyles.greyTextStyle()
                                            .copyWith(color: kWhiteTextColor)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Obx(
                                  () => controller.teamData.isEmpty
                                      ? CircleAvatar(
                                          radius: 50,
                                          child: Image.asset(
                                            kSettingsProfileImage,
                                            width: 100.w,
                                          ),
                                        )
                                      : CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(GetStorage().read('image'),),
                                        
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    GetStorage().read('name'),
                                    style: AppStyles.whiteTextStyle(),
                                  ),
                                  if (GetStorage().read('id') ==
                                      GetStorage().read('adminId'))
                                    Text(
                                      '(Admin)',
                                      style: AppStyles.greyTextStyle()
                                          .copyWith(color: kWhiteTextColor),
                                    )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: Text(
                              controller.teamName.value,
                              style: AppStyles.whiteTextStyle(),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 25.w),
                              child: Row(
                                children: [
                                  Image.asset(
                                    kPackagesIcon,
                                    width: 23.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '${controller.itemQuantity.value}',
                                    style: AppStyles.greyTextStyle()
                                        .copyWith(color: kWhiteTextColor),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Image.asset(
                                    kMembersIcon,
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '${controller.teamMembers.value}',
                                    style: AppStyles.greyTextStyle()
                                        .copyWith(color: kWhiteTextColor),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Image.asset(
                                    kLocationIcon,
                                    width: 17.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '${controller.teamLocations.value}',
                                    style: AppStyles.greyTextStyle()
                                        .copyWith(color: kWhiteTextColor),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: Get.width,
                        height: 59.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: kDisableButtonColor.withOpacity(0.3),
                            border: Border.all(
                                color: kDisableButtonColor, width: 1.5)),
                        child: Center(
                          child: Text(
                            'Change Team',
                            style: AppStyles.greyTextStyle()
                                .copyWith(fontSize: 20.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 390.w,
                        height: 290.h,
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
                          padding: EdgeInsets.only(top: 15.h, left: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Manage Team',
                                style: AppStyles.blackTextStyle().copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showRenameModal(
                                      context, controller.changeTeamName);
                                },
                                child: CustomRow1(
                                  text: 'Team Name',
                                  selectedText: controller.teamName,
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showNoteModal(context, controller.notes);
                                },
                                child: CustomRow1(
                                  text: 'Notes',
                                  selectedText: controller.dummyNote,
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(kSettingsTimezoneRoute);
                                },
                                child: CustomRow1(
                                  text: 'Time Zone',
                                  selectedText: controller.timezone,
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(kSettingsCurrencyRoute);
                                },
                                child: CustomRow1(
                                  text: 'Currency',
                                  selectedText: controller.selectedCurrency,
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(kSettingsMembersRoute);
                                },
                                child: CustomRow1(
                                  text: 'Members',
                                  selectedText: controller.members,
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.toNamed(kSettingsManageRolesRoute);
                              //   },
                              //   child: CustomRow(
                              //     text: 'Manage Roles',
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 19.w,
                              // ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(kAddMembersRoute);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          size: 20,
                                          color: kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          'Invite',
                                          style: AppStyles.greenTextStyle(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 390.w,
                        height: 143.h,
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
                          padding: EdgeInsets.only(top: 15.h, left: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Team Settings',
                                style: AppStyles.blackTextStyle().copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(kSettingsMyTeamsRoute);
                                },
                                child: const CustomRow(
                                  text: 'My Teams',
                                ),
                              ),
                              SizedBox(
                                height: 19.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(kCreateTeamRoute);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          size: 20,
                                          color: kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          'Add New Team',
                                          style: AppStyles.greenTextStyle(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     width: 390.w,
                    //     height: 130.h,
                    //     decoration: ShapeDecoration(
                    //       color: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8.r)),
                    //       shadows: [
                    //         BoxShadow(
                    //           color: kBoxShadowColor,
                    //           blurRadius: 10.r,
                    //           offset: const Offset(0, 0),
                    //           spreadRadius: 0,
                    //         )
                    //       ],
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.only(top: 15.h, left: 25.w),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Attribute Settings',
                    //             style: AppStyles.blackTextStyle().copyWith(
                    //               fontSize: 20.sp,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 20.w,
                    //           ),
                    //           GestureDetector(
                    //             onTap: () {
                    //               Get.toNamed(kSettingsItemsRoute);
                    //             },
                    //             child: CustomRow1(
                    //               selectedText: controller.items,
                    //               text: 'Items',
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 17.w,
                    //           ),
                    //           GestureDetector(
                    //             onTap: () {
                    //               Get.toNamed(kSettingsDisplayFormatRoute);
                    //             },
                    //             child: CustomRow(
                    //               text: 'Display Format',
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 390.w,
                        height: 130.h,
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
                          padding: EdgeInsets.only(top: 15.h, left: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Partner Settings',
                                style: AppStyles.blackTextStyle().copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                      kSettingsCustomerSupplierListRoute,
                                      arguments: {'title': 'Supplier'});
                                },
                                child: CustomRow1(
                                  selectedText: controller.suppliers,
                                  text: 'Suppliers',
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                      kSettingsCustomerSupplierListRoute,
                                      arguments: {'title': 'Customer'});
                                },
                                child: CustomRow1(
                                  selectedText: controller.customers,
                                  text: 'Customers',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    if (GetStorage().read('mode') == 'Location Mode')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 390.w,
                          height: 95.h,
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
                            padding: EdgeInsets.only(top: 15.h, left: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location Settings',
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(kSettingsLocationRoute);
                                  },
                                  child: CustomRow1(
                                    selectedText: controller.location,
                                    text: 'Location',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  void _showRenameModal(
      BuildContext context, TextEditingController controllerText) {
    TextEditingController renameController =
        TextEditingController(text: controllerText.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Update Name',
                    style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15.h,
                ),
                Text('Input New Name',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 15.sp,
                    )),
                SizedBox(height: 20.h),
                TextField(
                  controller: renameController,
                  decoration: const InputDecoration(
                    hintText: 'Input new name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
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
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',
                            style: AppStyles.blackTextStyle()
                                .copyWith(fontSize: 18.sp)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 20.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controllerText.text = renameController.text;
                          controller.updateTeamName();
                          Navigator.pop(context);
                        },
                        child: Text('OK', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNoteModal(
      BuildContext context, TextEditingController controllerText) {
    TextEditingController renameController =
        TextEditingController(text: controllerText.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Note',
                    style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15.h,
                ),
                Text('Input New Note',
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 15.sp,
                    )),
                SizedBox(height: 20.h),
                TextField(
                  controller: renameController,
                  decoration: const InputDecoration(
                    hintText: 'Input new note',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
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
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',
                            style: AppStyles.blackTextStyle()
                                .copyWith(fontSize: 18.sp)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 20.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controllerText.text = renameController.text;

                          final newNote = Notes(
                              note: controllerText.text.trim(),
                              teamId: GetStorage().read('teamId'));
                          controller.addNoteToFirestore(newNote);
                          Navigator.pop(context);
                        },
                        child: Text('OK', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomRow extends StatelessWidget {
  final String text;

  const CustomRow({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: AppStyles.blackTextStyle().copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: kBlackTextColor.withOpacity(0.7)),
        ),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 20.sp,
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}

class CustomRow1 extends StatelessWidget {
  final String text;
  final RxString? selectedText;

  const CustomRow1({
    super.key,
    required this.text,
    this.selectedText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: AppStyles.blackTextStyle().copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: kBlackTextColor.withOpacity(0.7)),
        ),
        const Spacer(),
        Obx(
          () => Text(
            selectedText!.value,
            style: AppStyles.blackTextStyle().copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: kBlackTextColor.withOpacity(0.7)),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 20.sp,
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}
