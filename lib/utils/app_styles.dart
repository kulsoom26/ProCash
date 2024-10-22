import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle blackTextStyle() => GoogleFonts.leagueSpartan(
      fontSize: 20.sp, fontWeight: FontWeight.w400, color: kBlackTextColor);
  static TextStyle greyTextStyle() => GoogleFonts.leagueSpartan(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: kGreyTextColor);
  static TextStyle whiteTextStyle() => GoogleFonts.leagueSpartan(
      fontSize: 20.sp, fontWeight: FontWeight.w700, color: kWhiteTextColor);
  static TextStyle redTextStyle() => GoogleFonts.leagueSpartan(
      fontSize: 20.sp, fontWeight: FontWeight.w700, color: kRedTextColor);
  static TextStyle greenTextStyle() => GoogleFonts.leagueSpartan(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: kGreenButtonColor);
  static TextStyle stockTextStyle() => GoogleFonts.leagueSpartan(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: kStock1TextColor);
  static TextStyle appBarHeadingTextStyle() => GoogleFonts.leagueSpartan(
      fontSize: 24.sp, fontWeight: FontWeight.w700, color: kBlackTextColor);
}
