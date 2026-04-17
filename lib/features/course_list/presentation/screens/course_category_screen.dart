// ignore_for_file: deprecated_member_use
import 'package:arabas_app/core/constants/app_images.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/course_list/presentation/screens/subcategory_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCategoryScreen extends StatelessWidget {
  const CourseCategoryScreen({super.key});

  final List<Map<String, String>> sections = const [
    {"title": "الجراحة", "image": AppImages.heart},
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

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,

                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "التميز الأكاديمي",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "تصنيفات الكورسات الطبية",
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      textAlign: TextAlign.right,
                      "استكشف مكتبتنا الشاملة من المحتوي التعليمي المتخصص  المصمم للأطباء وطلبة الطب",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(8.h),
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 230, 248),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ابحث عن تخصص",
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),

                    Icon(Icons.search, color: Color(0xff837379)),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              ListView.builder(
                itemCount: sections.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = sections[index];

                  return CourseCard(
                    title: item["title"]!,
                    image: item["image"]!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => SubCategoryListScreen(
                                categoryName: item["title"]!,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 28.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(18.w, 24.h, 18.w, 24.h),
              decoration: BoxDecoration(
                color: const Color(0xffE7EBF0),
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 40.h),

                  /// العنوان
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    "من الجراحة العامة إلى التخصصات الدقيقة، دروس شاملة في التقنيات الجراحية الحديثة.",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black.withOpacity(.7),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "استعرض الكورسات",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(Icons.arrow_forward, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              left: 18.w,
              top: -20.h,
              child: Column(
                children: [
                  Container(
                    height: 90.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Badge عدد الكورسات
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffDCE6E6),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      "124 كورس",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
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
