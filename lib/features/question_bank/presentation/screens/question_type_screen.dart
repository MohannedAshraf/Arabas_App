// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/question_bank/presentation/screens/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionTypeScreen extends StatelessWidget {
  final String title;

  const QuestionTypeScreen({super.key, required this.title});

  final List<String> types = const ["صح وغلط", "اختياري", "مقالي"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        title: Text(
          title,
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
        itemCount: types.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) =>
                          QuestionsScreen(type: types[index], section: title),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(16.w),
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
              child: Center(
                child: Text(
                  types[index],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
