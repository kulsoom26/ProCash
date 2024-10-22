import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';

class CustomTextField1 extends StatelessWidget {
  const CustomTextField1({
    required this.label,
    required this.hint,
    required this.controller,
    this.isSuffix,
    required this.isEditable,
    this.maxLines,
    super.key,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget? isSuffix;
  final bool isEditable;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isEditable,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        suffixIcon: isSuffix ?? Container(width: 1.w,) ,
        labelText: label,
        labelStyle: TextStyle(
          color: kPrimaryColor, 
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        hintText: hint,
        hintStyle: AppStyles.greyTextStyle().copyWith(
          color: kGreyButtonColor,
          fontSize: 15.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 12.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0), 
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPrimaryColor, 
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

