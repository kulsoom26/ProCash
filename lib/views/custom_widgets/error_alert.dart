import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/utils/app_styles.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: kRedButtonColor,
              child: Center(
                child: Icon(
              Icons.close,
              color: kWhiteButtonColor,
              size: 40.sp,
            ),
              ),
            ),
            
            SizedBox(height: 20.h),
            Text(
              'Error!',
              style: AppStyles.redTextStyle().copyWith(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Something went wrong!',
              textAlign: TextAlign.center,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(color: Colors.black),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go Back', style: TextStyle(fontSize: 16.sp)),
      ),
    ),
    SizedBox(width: 10.w), 
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: kRedButtonColor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Try Again', style: TextStyle(fontSize: 16.sp)),
      ),
    ),
  ],
),
          ],
        ),
      ),
    );
  }
}
