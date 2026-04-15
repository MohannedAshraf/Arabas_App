// ignore_for_file: deprecated_member_use

import 'package:arabas_app/features/course_list/presentation/screens/course_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';

class SubCategoryListScreen extends StatelessWidget {
  final String categoryName;

  const SubCategoryListScreen({super.key, required this.categoryName});

  /// هنا هنحدد كورسات لكل قسم (مؤقتاً Static لحد ما نربط API)
  List<Map<String, String>> getCourses() {
    if (categoryName == "قلب") {
      return [
        {
          "title": "Cardiology Basics",
          "desc": "مقدمة في أمراض القلب",
          "image": AppImages.heart,
        },
        {
          "title": "ECG Masterclass",
          "desc": "شرح رسم القلب بالتفصيل",
          "image": AppImages.heart,
        },
        {
          "title": "Heart Failure",
          "desc": "تشخيص وعلاج فشل القلب",
          "image": AppImages.heart,
        },
        {
          "title": "Cardiology Basics",
          "desc": "مقدمة في أمراض القلب",
          "image": AppImages.heart,
        },
        {
          "title": "ECG Masterclass",
          "desc": "شرح رسم القلب بالتفصيل",
          "image": AppImages.heart,
        },
        {
          "title": "Heart Failure",
          "desc": "تشخيص وعلاج فشل القلب",
          "image": AppImages.heart,
        },
        {
          "title": "Cardiology Basics",
          "desc": "مقدمة في أمراض القلب",
          "image": AppImages.heart,
        },
        {
          "title": "ECG Masterclass",
          "desc": "شرح رسم القلب بالتفصيل",
          "image": AppImages.heart,
        },
        {
          "title": "Heart Failure",
          "desc": "تشخيص وعلاج فشل القلب",
          "image": AppImages.heart,
        },
      ];
    } else if (categoryName == "أسنان") {
      return [
        {
          "title": "Dental Anatomy",
          "desc": "تشريح الأسنان",
          "image": AppImages.teeth,
        },
        {
          "title": "Oral Surgery",
          "desc": "جراحة الفم",
          "image": AppImages.teeth,
        },
        {
          "title": "Dental Anatomy",
          "desc": "تشريح الأسنان",
          "image": AppImages.teeth,
        },
        {
          "title": "Oral Surgery",
          "desc": "جراحة الفم",
          "image": AppImages.teeth,
        },
        {
          "title": "Dental Anatomy",
          "desc": "تشريح الأسنان",
          "image": AppImages.teeth,
        },
        {
          "title": "Oral Surgery",
          "desc": "جراحة الفم",
          "image": AppImages.teeth,
        },
        {
          "title": "Dental Anatomy",
          "desc": "تشريح الأسنان",
          "image": AppImages.teeth,
        },
        {
          "title": "Oral Surgery",
          "desc": "جراحة الفم",
          "image": AppImages.teeth,
        },
        {
          "title": "Dental Anatomy",
          "desc": "تشريح الأسنان",
          "image": AppImages.teeth,
        },
        {
          "title": "Dental Anatomy",
          "desc": "تشريح الأسنان",
          "image": AppImages.teeth,
        },
        {
          "title": "Oral Surgery",
          "desc": "جراحة الفم",
          "image": AppImages.teeth,
        },
        {
          "title": "Dental Anatomy",
          "desc": "تشريح الأسنان",
          "image": AppImages.teeth,
        },
        {
          "title": "Oral Surgery",
          "desc": "جراحة الفم",
          "image": AppImages.teeth,
        },
      ];
    } else if (categoryName == "عيون") {
      return [
        {
          "title": "Ophthalmology Basics",
          "desc": "أساسيات طب العيون",
          "image": AppImages.eye,
        },
        {
          "title": "Retina Course",
          "desc": "أمراض الشبكية",
          "image": AppImages.eye,
        },
        {
          "title": "Ophthalmology Basics",
          "desc": "أساسيات طب العيون",
          "image": AppImages.eye,
        },
        {
          "title": "Retina Course",
          "desc": "أمراض الشبكية",
          "image": AppImages.eye,
        },
        {
          "title": "Ophthalmology Basics",
          "desc": "أساسيات طب العيون",
          "image": AppImages.eye,
        },
        {
          "title": "Retina Course",
          "desc": "أمراض الشبكية",
          "image": AppImages.eye,
        },
        {
          "title": "Ophthalmology Basics",
          "desc": "أساسيات طب العيون",
          "image": AppImages.eye,
        },
        {
          "title": "Retina Course",
          "desc": "أمراض الشبكية",
          "image": AppImages.eye,
        },
        {
          "title": "Ophthalmology Basics",
          "desc": "أساسيات طب العيون",
          "image": AppImages.eye,
        },
      ];
    } else {
      return [
        {
          "title": "ENT Basics",
          "desc": "أنف وأذن وحنجرة",
          "image": AppImages.nose,
        },
        {
          "title": "Sinusitis Course",
          "desc": "علاج الجيوب الأنفية",
          "image": AppImages.nose,
        },
        {
          "title": "ENT Basics",
          "desc": "أنف وأذن وحنجرة",
          "image": AppImages.nose,
        },
        {
          "title": "Sinusitis Course",
          "desc": "علاج الجيوب الأنفية",
          "image": AppImages.nose,
        },
        {
          "title": "ENT Basics",
          "desc": "أنف وأذن وحنجرة",
          "image": AppImages.nose,
        },
        {
          "title": "Sinusitis Course",
          "desc": "علاج الجيوب الأنفية",
          "image": AppImages.nose,
        },
        {
          "title": "ENT Basics",
          "desc": "أنف وأذن وحنجرة",
          "image": AppImages.nose,
        },
        {
          "title": "Sinusitis Course",
          "desc": "علاج الجيوب الأنفية",
          "image": AppImages.nose,
        },
        {
          "title": "ENT Basics",
          "desc": "أنف وأذن وحنجرة",
          "image": AppImages.nose,
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = getCourses();

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        title: Text(
          categoryName, // اسم القسم اللي وصلنا
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
        padding: EdgeInsets.only(top: 12.h),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          return _mainCard(
            title: course["title"]!,
            desc: course["desc"]!,
            image: course["image"]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => CourseDetailsScreen(
                        courseName: course["title"]!,
                        categoryName: categoryName,
                        image: course["image"]!,
                        description: course["desc"]!,
                        price: "350 ",
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _mainCard({
    required String title,
    required String desc,
    required String image,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, left: 8.w, right: 8.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, height: 70.h, width: 100.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    desc,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.sp,
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
  }
}
