// ignore_for_file: deprecated_member_use, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseName;
  final String categoryName;
  final String image;
  final String description;
  final String price;

  const CourseDetailsScreen({
    super.key,
    required this.courseName,
    required this.categoryName,
    required this.image,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Column(
        children: [
          /// صورة الكورس (ثلث الشاشة)
          Stack(
            children: [
              SizedBox(
                height: 0.33.sh,
                width: double.infinity,
                child: Image.asset(image, fit: BoxFit.cover),
              ),

              Positioned(
                top: 40.h,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                    size: 28.sp,
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 8.h),

                  /// اسم الكورس + اسم القسم
                  Row(
                    children: [
                      Text(
                        courseName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textGray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// عنوان الوصف
                  Text(
                    "وصف الكورس",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// الوصف
                  Text(
                    description +
                        " - هذا الكورس يشرح المفاهيم الطبية بشكل مبسط وشامل ويحتوي على أمثلة عملية وحالات حقيقية تساعدك على الفهم الكامل.",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 1.6,
                      color: AppColors.textGray,
                    ),
                  ),

                  const Spacer(),

                  /// السعر + زر الحجز
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "احجز $price",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
