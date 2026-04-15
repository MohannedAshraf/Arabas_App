// ignore_for_file: deprecated_member_use
import 'package:arabas_app/features/free_lectures/presentation/screens/lecture_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';

class FreeLecturesScreen extends StatelessWidget {
  const FreeLecturesScreen({super.key});

  final List<Map<String, String>> lectures = const [
    {
      "title": "مقدمة في أمراض القلب",
      "desc": "شرح أساسيات أمراض القلب والتشخيص",
      "image": AppImages.heart,
      "video":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    },
    {
      "title": "فحص الأنف والأذن",
      "desc": "طريقة الفحص السريري خطوة بخطوة",
      "image": AppImages.nose,
      "video":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    },
    {
      "title": "أساسيات طب العيون",
      "desc": "التعامل مع أشهر أمراض العيون",
      "image": AppImages.eye,
      "video":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        title: Text(
          "المحاضرات المجانية",
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
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          final item = lectures[index];

          return _mainCard(
            title: item["title"]!,
            desc: item["desc"]!,
            image: item["image"]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => LectureDetailsScreen(
                        title: item["title"]!,
                        description: item["desc"]!,
                        videoUrl: item["video"]!,
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
          color: Colors.white,
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
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    desc,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textGray,
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
