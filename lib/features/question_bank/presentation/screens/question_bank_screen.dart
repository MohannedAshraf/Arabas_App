// ignore_for_file: deprecated_member_use
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/question_bank/presentation/screens/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionBankScreen extends StatelessWidget {
  const QuestionBankScreen({super.key});

  final List<Map<String, dynamic>> sections = const [
    {
      "title": "قلب",
      "desc": "أمراض القلب والطوارئ القلبية",
      "questions": "520",
    },
    {
      "title": "عيون",
      "desc": "الشبكية والمياه البيضاء والزرقاء",
      "questions": "430",
    },
    {
      "title": "أنف وأذن وحنجرة",
      "desc": "الجيوب الأنفية والسمع",
      "questions": "410",
    },
    {"title": "أسنان", "desc": "التسوس وجراحة الفم", "questions": "390"},
    {"title": "باطنة", "desc": "الأمراض المزمنة والهضم", "questions": "600"},
    {"title": "أطفال", "desc": "أمراض وحديثي الولادة", "questions": "550"},
    {"title": "نساء وتوليد", "desc": "الحمل والولادة", "questions": "530"},
    {"title": "عظام", "desc": "الكسور والمفاصل", "questions": "470"},
    {"title": "مخ وأعصاب", "desc": "الأعصاب والجلطات", "questions": "490"},
    {"title": "جلدية", "desc": "الأمراض الجلدية", "questions": "360"},
    {"title": "طوارئ", "desc": "الحالات الحرجة", "questions": "450"},
    {
      "title": "جراحة عامة",
      "desc": "العمليات والبطن الحاد",
      "questions": "610",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        title: Text(
          "بنك الأسئلة",
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
              SizedBox(height: 10.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "ابدأ المذاكرة الآن",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "اختر التخصص وابدأ حل آلاف الأسئلة الطبية",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                height: 80.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Color(0xffEDF4FF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "تعلّم وراجع بسرعة",
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Icon(
                        Icons.search_outlined,
                        color: Color(0xff837379),
                        size: 36.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              ListView.builder(
                itemCount: sections.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemBuilder: (context, index) {
                  final item = sections[index];

                  return _NewSectionCard(
                    title: item["title"],
                    description: item["desc"],
                    questions: item["questions"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => QuestionsScreen(section: item["title"]),
                        ),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewSectionCard extends StatelessWidget {
  final String title;
  final String description;
  final String questions;
  final VoidCallback onTap;

  const _NewSectionCard({
    required this.title,
    required this.description,
    required this.questions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Color(0xffE2EFFF),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10.h),

            Text(
              "$title ",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10.h),

            /// الوصف
            Text(
              description,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 15.sp,
                height: 1.5,
              ),
            ),

            SizedBox(height: 18.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.open_in_new, color: AppColors.primary),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "عدد الأسئلة",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        questions,
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
