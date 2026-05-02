import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final String role;

  const ProfileHeader({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 25.h, top: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),

          /// Avatar with border
          CircleAvatar(
            radius: 48.r,
            backgroundColor: AppColors.primary,
            child: CircleAvatar(
              radius: 45.r,
              backgroundImage: NetworkImage(image),
            ),
          ),

          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              role.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            name,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email_outlined, color: AppColors.primary, size: 32.sp),
              SizedBox(width: 12.w),
              Text(email, style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ],
      ),
    );
  }
}
