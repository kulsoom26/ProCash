import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;
  final TextStyle textStyle;
  final bool isTextCentered;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback onPressed;
  final double? borderRadius;
  final Color? borderColor;
  final Color? shadowColor;
  final double? shadowBlurRadius;
  final Offset? shadowOffset;

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.textStyle,
    this.isTextCentered = true,
    this.prefixIcon,
    this.suffixIcon,
    required this.onPressed,
    this.borderRadius,
    this.borderColor,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowOffset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 40.r),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: shadowColor != null
              ? [
                  BoxShadow(
                    color: shadowColor!,
                    blurRadius: shadowBlurRadius ?? 10.0,
                    offset: shadowOffset ?? Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: isTextCentered
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: textStyle,
            ),
            if (suffixIcon != null) ...[
              SizedBox(width: 8.w),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
