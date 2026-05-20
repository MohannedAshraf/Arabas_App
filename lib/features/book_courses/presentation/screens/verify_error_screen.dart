// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyErrorScreen extends StatelessWidget {
  const VerifyErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F5FA),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.1),
                shape: BoxShape.circle,
              ),

              child: Icon(Icons.cancel, color: Colors.red, size: 120.sp),
            ),

            SizedBox(height: 30.h),

            Text(
              "الكود غير صحيح",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              "يرجى التأكد من الكود والمحاولة مرة أخرى",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: AppColors.textGray),
            ),

            SizedBox(height: 50.h),

            SizedBox(
              width: double.infinity,

              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),

                child: Text(
                  "إعادة المحاولة",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 15.h),

            SizedBox(
              width: double.infinity,

              child: TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },

                style: TextButton.styleFrom(
                  backgroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),

                child: Text(
                  "العودة للرئيسية",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
