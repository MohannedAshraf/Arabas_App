// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/constants/app_images.dart';
import 'package:arabas_app/features/home/presentation/screens/announcement_screen.dart';
import 'package:arabas_app/features/question_bank/presentation/screens/question_bank_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xffF7F5FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),

              SizedBox(height: 5.h),

              _mainCard(
                title: "تعرف على المؤسسة",
                desc: "نبذة عن المؤسسه وأهدافها والخدمات المقدمه",
                image: AppImages.aboutOrg,
                onTap: () {},
              ),

              _mainCard(
                title: "أهم البرامج التدريبية",
                desc: "الدبلومة المتقدمه في أطفال الأنابيب والعقم",
                image: AppImages.bestProg,
                onTap: () {},
              ),

              _mainCard(
                title: "كورسات مسجلة",
                desc: "كورسات مسجله جاهزة للمشاهدة في اي وقت واي  مكان",
                image: AppImages.recordedCourses,
                onTap: () {},
              ),

              Row(
                children: [
                  Expanded(
                    child: _smallCard(
                      title: "بنك الأسئلة",
                      desc: "تدرب علي ألاف الأسئلة الطبية",
                      image: AppImages.questionBank,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuestionBankScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _smallCard1(
                      title: "التدريب العملي",
                      desc: "فرص تدريب عملي ",
                      image: AppImages.training,
                      onTap: () {},
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: _smallCard(
                      title: "برنامج إدارة العيادة",
                      desc: "نظام متكامل لإدارة العيادات ",
                      image: AppImages.clinic,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _smallCard1(
                      title: "كتب طبية",
                      desc: "مجموعة مختارة من أفضل الكتب",
                      image: AppImages.medicalBooks,
                      onTap: () {},
                    ),
                  ),
                ],
              ),

              _freeSection(onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  /// HEADER
  Widget _header() {
    return Container(
      color: AppColors.primary,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              _logoCircle(AppImages.logo),
              SizedBox(width: 12.w),
              _logoCircle(AppImages.logo2),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            "المؤسسة العربية للتعليم والتدريب",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "(ARABAS) - CPD 20960",
            style: TextStyle(fontSize: 12.sp, color: AppColors.white),
          ),
          SizedBox(height: 5.h),
          Text(
            " السلام عليكم يا دكتور",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: _announcement(),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  /// ANNOUNCEMENT
  Widget _announcement() {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnnouncementScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.campaign, color: AppColors.primary),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "إعلان هام: اكتشف برامجنا الجديدة\nللعام الجاري! اضغط لمشاهدة التفاصيل.",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "إعلانات",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// MAIN CARD
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
                  SizedBox(height: 1.h),
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

  /// SMALL CARD
  Widget _smallCard({
    required String title,
    required String image,
    required String desc,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.h,

        margin: EdgeInsets.only(bottom: 12.h, left: 8.w),
        padding: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          top: 15.h,
          bottom: 15.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, height: 70.h, width: 50.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),

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

  Widget _smallCard1({
    required String title,
    required String image,
    required String desc,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.h,

        margin: EdgeInsets.only(bottom: 12.h, right: 8.w),
        padding: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          top: 15.h,
          bottom: 15.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, height: 70.h, width: 55.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),

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

  /// FREE SECTION
  Widget _freeSection({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                AppImages.free,
                height: 80.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "القسم المجاني",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Text(
                    "محتوى مجاني شامل ومفيد",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textGray,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "اعرف المزيد",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
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

  Widget _logoCircle(String image) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 35.r,
        backgroundImage: AssetImage(image),
        backgroundColor: Colors.white,
      ),
    );
  }
}
