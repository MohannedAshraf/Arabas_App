// ignore_for_file: deprecated_member_use

import 'package:arabas_app/features/course_list/presentation/screens/course_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';

class SubCategoryListScreen extends StatelessWidget {
  final String categoryName;

  const SubCategoryListScreen({super.key, required this.categoryName});

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

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          /// ====== HEADER CARD ======
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20.h),
                Container(
                  height: 24.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Center(
                    child: Text(
                      "فئة مميزه",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  categoryName,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "استكشف مجموعة مختارة من المسارات الطبية",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white.withOpacity(.8),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "المتقدمة في الجراحة مصممة من قبل كبار",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white.withOpacity(.8),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "الجراحين لتقديم تجربة تعليمية سريرية متكاملة",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white.withOpacity(.8),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  margin: EdgeInsets.only(right: 4.w),
                  height: 48.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Center(
                    child: Text(
                      "ابدأ التعلم",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// ====== COURSES LIST ======
          ...courses.map(
            (course) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _courseCard(
                title: course["title"]!,
                desc: course["desc"]!,
                image: course["image"]!,
                price: 350,
                category: categoryName,
                doctorName: "د. أحمد علي",
                courseTime: 45,
                courseRating: 4.9,
                courseUnits: 24,
                badgeColor: AppColors.white,
                badgeText: "جديد",
                badgeTextColor: AppColors.primary,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _mainCard({
  //   required String title,
  //   required String desc,
  //   required String image,
  //   required VoidCallback? onTap,
  // }) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       margin: EdgeInsets.only(bottom: 12.h, left: 8.w, right: 8.w),
  //       padding: EdgeInsets.all(8.w),
  //       decoration: BoxDecoration(
  //         color: AppColors.primary,
  //         borderRadius: BorderRadius.circular(16.r),
  //         boxShadow: [
  //           BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Image.asset(image, height: 70.h, width: 100.w),
  //           SizedBox(width: 10.w),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   title,
  //                   textAlign: TextAlign.right,
  //                   style: TextStyle(
  //                     fontSize: 18.sp,
  //                     fontWeight: FontWeight.bold,
  //                     color: AppColors.white,
  //                   ),
  //                 ),
  //                 SizedBox(height: 1.h),
  //                 Text(
  //                   desc,
  //                   textAlign: TextAlign.right,
  //                   style: TextStyle(
  //                     fontSize: 14.sp,
  //                     color: AppColors.white.withOpacity(.8),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _courseCard({
    required String title,
    required String desc,
    required String image,
    required VoidCallback? onTap,
    required int price,
    required String category,
    required String doctorName,
    required int courseTime,
    required double courseRating,
    required double courseUnits,
    required Color badgeColor,
    required String badgeText,
    required Color badgeTextColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  height: 220.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 16.h,
                  left: 12.w,
                  child: Container(
                    height: 24.h,
                    width: 44.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        color: badgeTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            courseRating.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        category,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        doctorName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textGray,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        price.toString(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),

                      Text(
                        courseUnits.toString(), // متغير عدد الوحدات
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primaryLight,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.menu_book,
                        size: 18.sp,
                        color: AppColors.primaryLight,
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        courseTime.toString(), // متغير عدد الساعات
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primaryLight,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.access_time,
                        size: 18.sp,
                        color: AppColors.primaryLight,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
