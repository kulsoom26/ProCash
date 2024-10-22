import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_cash_food/utils/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onClear;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 59.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.50.w, color: const Color(0xFFE0E0E2)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            icon: Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: const Icon(Icons.search, color: kGreyTextColor, size: 30),
            ),
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: controller?.text.isNotEmpty == true
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: kGreyTextColor,
                      size: 30.sp,
                    ),
                    onPressed: () {
                      controller?.clear();
                      if (onClear != null) {
                        onClear!();
                      }
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
