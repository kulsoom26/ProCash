import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_cash_food/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hinttext;
  final String? labeltext;
  final TextEditingController? controller;
  final bool isPassword;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Color color;
  final int? maxLines;
  final bool? readOnly;

  const CustomTextField({
    super.key,
    required this.color,
    required this.hinttext,
    this.labeltext,
    this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    final textFieldController = Get.find<TextFieldController>();

    return Obx(
      () => Container(
        height: maxLines != null ? null : 59.h,
        width: 390.w,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          shadows: [
            BoxShadow(
              color: kBoxShadowColor,
              blurRadius: 10.r,
              offset: const Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: TextField(
          controller: controller,
          readOnly: readOnly ?? false,
          obscureText: textFieldController.isObscured.value && isPassword,
          keyboardType:
              isPassword ? TextInputType.visiblePassword : TextInputType.text,
          cursorColor: kGreyTextColor,
          style: const TextStyle(
            color: kBlackTextColor,
          ),
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.w,
                color: kGreyTextColor,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.w,
                color: kGreyTextColor,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            hintText: hinttext,
            hintStyle: GoogleFonts.inter(
              textStyle: TextStyle(
                color: kGreyTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            labelText: labeltext,
            labelStyle: labeltext != null
                ? GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  )
                : null,
            floatingLabelBehavior: labeltext != null
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.never,
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: textFieldController.toggleObscure,
                    icon: Icon(
                      textFieldController.isObscured.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kGreyTextColor,
                    ),
                  )
                : suffixIcon,
          ),
        ),
      ),
    );
  }
}

class TextFieldController extends GetxController {
  var isObscured = true.obs;

  void toggleObscure() {
    isObscured.value = !isObscured.value;
  }
}
