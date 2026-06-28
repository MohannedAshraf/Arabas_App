// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arabas_app/core/theme/app_colors.dart';

class SubscribeButton extends StatelessWidget {
  final double price;
  final VoidCallback? onPressed;

  const SubscribeButton({super.key, required this.price, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.08),
            blurRadius: 40,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 150.w,
            height: 56.h,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              gradient: LinearGradient(
                colors: [Color(0XFF5F2444), Color(0XFF7A3B5C)],
              ),
            ),

            child: Center(
              child: TextButton(
                onPressed: onPressed,

                child: Text(
                  "اشترك الآن",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),

          Spacer(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "السعر الكلي",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 6.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    price.toStringAsFixed(0),
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(width: 6.w),

                  Text(
                    "EGP",
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
