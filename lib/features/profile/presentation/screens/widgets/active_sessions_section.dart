// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveSessionsSection extends StatelessWidget {
  final List<String> devices;
  final List<String> platforms;

  const ActiveSessionsSection({
    super.key,
    required this.devices,
    required this.platforms,
  });

  /// device card (blue container)
  Widget deviceTile(String device, String platform) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Color(0xffEDF4FF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          /// circle icon background
          Container(
            width: 60.w,
            height: 60.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.smartphone,
              color: AppColors.textGray,
              size: 30.sp,
            ),
          ),

          SizedBox(width: 8.w),

          /// text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device,
                style: TextStyle(fontSize: 13.sp, color: AppColors.black),
              ),
              SizedBox(height: 10.h),
              Text(
                " $platform",
                style: TextStyle(fontSize: 13.sp, color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// header row (title + security button)
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Active Sessions",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        const Spacer(),

        /// SECURITY pill button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withOpacity(.2),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            "SECURITY",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          SizedBox(height: 20.h),
          ...List.generate(
            devices.length,
            (i) => deviceTile(devices[i], platforms[i]),
          ),
        ],
      ),
    );
  }
}
