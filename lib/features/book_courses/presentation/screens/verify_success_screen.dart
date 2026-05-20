// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course-book_cubit.dart';
import 'package:arabas_app/features/book_courses/presentation/screens/course_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifySuccessScreen extends StatelessWidget {
  const VerifySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F5FA),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.green.withOpacity(.1),
                shape: BoxShape.circle,
              ),

              child: Icon(
                Icons.check_circle,
                color: AppColors.green,
                size: 120.sp,
              ),
            ),

            SizedBox(height: 30.h),

            Text(
              "تم تفعيل الكتاب بنجاح",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              "يمكنك الآن الوصول إلى كورسات الكتاب الخاصة بك",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: AppColors.textGray),
            ),

            SizedBox(height: 50.h),

            SizedBox(
              width: double.infinity,

              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider(
                            create:
                                (_) => sl<CourseBooksCubit>()..getCourseBooks(),
                            child: const CourseBooksScreen(),
                          ),
                    ),
                  );
                },

                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),

                child: Text(
                  "الذهاب إلى كورسات الكتاب",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 15.h),

            SizedBox(
              width: double.infinity,

              child: TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },

                style: TextButton.styleFrom(
                  backgroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),

                child: Text(
                  "العودة للرئيسية",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
