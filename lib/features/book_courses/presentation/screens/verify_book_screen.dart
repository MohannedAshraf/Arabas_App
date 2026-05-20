// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/verify_book_cubit.dart';
import 'package:arabas_app/features/book_courses/presentation/screens/verify_error_screen.dart';
import 'package:arabas_app/features/book_courses/presentation/screens/verify_success_screen.dart';
import 'package:arabas_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyBookScreen extends StatefulWidget {
  const VerifyBookScreen({super.key});

  @override
  State<VerifyBookScreen> createState() => _VerifyBookScreenState();
}

class _VerifyBookScreenState extends State<VerifyBookScreen> {
  final TextEditingController codeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VerifyBookCubit>(),
      child: BlocConsumer<VerifyBookCubit, VerifyBookState>(
        listener: (context, state) {
          if (state is VerifyBookSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VerifySuccessScreen()),
            );
          }

          if (state is VerifyBookError) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VerifyErrorScreen()),
            );
          }
        },

        builder: (context, state) {
          final cubit = context.read<VerifyBookCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              centerTitle: true,

              leading: const BackButton(color: AppColors.primary),

              title: Text(
                "Verify Book",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),

                    Text(
                      "Book Verification",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      "ادخل الكود الموجود على الكتاب لتفعيل الكورسات الخاصة به",
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 13.sp,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    TextFormField(
                      controller: codeController,
                      cursorColor: AppColors.primary,

                      decoration: InputDecoration(
                        hintText: "Enter Book Code",

                        hintStyle: TextStyle(
                          color: AppColors.lightGray,
                          fontSize: 13.sp,
                        ),

                        filled: true,
                        fillColor: AppColors.white,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: AppColors.lightGray.withOpacity(.3),
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: AppColors.lightGray.withOpacity(.3),
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter code";
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            bottomNavigationBar: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 25.h),
              child: TextButton(
                onPressed:
                    state is VerifyBookLoading
                        ? null
                        : () {
                          if (formKey.currentState!.validate()) {
                            cubit.verifyBook(codeController.text.trim());
                          }
                        },

                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),

                child:
                    state is VerifyBookLoading
                        ? SizedBox(
                          height: 22.h,
                          width: 22.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : Text(
                          "Apply Coupon",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
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
