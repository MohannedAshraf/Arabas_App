// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/constants/app_images.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/course_list/presentation/screens/subcategory_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCategoryScreen extends StatelessWidget {
  const CourseCategoryScreen({super.key});

  final List<Map<String, String>> sections = const [
    {"title": "أنف وأذن وحنجرة", "image": AppImages.nose},
    {"title": "عيون", "image": AppImages.eye},
    {"title": "أسنان", "image": AppImages.teeth},
    {"title": "قلب", "image": AppImages.heart},
    {"title": "أنف وأذن وحنجرة", "image": AppImages.nose},
    {"title": "عيون", "image": AppImages.eye},
    {"title": "أسنان", "image": AppImages.teeth},
    {"title": "قلب", "image": AppImages.heart},
    {"title": "قلب", "image": AppImages.heart},
    {"title": "أنف وأذن وحنجرة", "image": AppImages.nose},
    {"title": "عيون", "image": AppImages.eye},
    {"title": "أسنان", "image": AppImages.teeth},
    {"title": "قلب", "image": AppImages.heart},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        title: Text(
          "الكورسات",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final item = sections[index];

          return InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) =>
                          SubCategoryListScreen(categoryName: item["title"]!),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 14.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      item["image"]!,
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item["title"]!,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "اضغط لعرض الكورسات",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.white.withOpacity(.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
