// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_entity.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_cubit.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_details_cubit.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_state.dart';
import 'package:arabas_app/features/my_diploma/presentation/screens/my_diploma_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDiplomasScreen extends StatelessWidget {
  const MyDiplomasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyDiplomaCubit>()..getMyDiplomas(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColors.black),
          title: Text(
            "دوراتي",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// الجزء الثابت (لن يعاد بناؤه مع الـ Bloc)
                Text(
                  "My Diplomas",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "Track your progress across your active diploma programs. keep up the great work.",
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textGray),
                ),

                SizedBox(height: 20.h),

                /// الجزء الذي يعتمد على الـ State فقط
                BlocBuilder<MyDiplomaCubit, MyDiplomaState>(
                  builder: (context, state) {
                    if (state is MyDiplomaLoading) {
                      return SizedBox(
                        height: 400.h,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is MyDiplomaError) {
                      return SizedBox(
                        height: 400.h,
                        child: Center(child: Text(state.message)),
                      );
                    }

                    if (state is MyDiplomaSuccess) {
                      if (state.diplomas.isEmpty) {
                        return SizedBox(
                          height: 400.h,
                          child: Center(
                            child: Text(
                              "لا توجد دورات مشترك بها",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.textGray,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.diplomas.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => SizedBox(height: 24.h),
                        itemBuilder: (context, index) {
                          return _DiplomaCard(diploma: state.diplomas[index]);
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DiplomaCard extends StatelessWidget {
  final MyDiplomaEntity diploma;

  const _DiplomaCard({required this.diploma});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
                child: Image.network(
                  diploma.diplomaImage,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      height: 200.h,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image),
                    );
                  },
                ),
              ),

              Positioned(
                bottom: 16.h,
                right: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    "${diploma.progressPercent.toInt()}%",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        diploma.diplomaName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),

                    SizedBox(width: 16.w),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BlocProvider(
                                  create:
                                      (_) =>
                                          sl<MyDiplomaDetailsCubit>()
                                            ..getMyDiplomaDetails(
                                              diplomaId: diploma.diplomaId,
                                            ),
                                  child: MyDiplomaDetailsScreen(
                                    diplomaId: diploma.diplomaId,
                                  ),
                                ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(30.r),
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                          color: Color(0xffEDF4FF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.primary,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 18.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F8FF),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "${diploma.daysRemaining} يوم",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "الأيام المتبقية",
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),

                      Spacer(),
                      Container(
                        width: 52.w,
                        height: 52.w,
                        decoration: const BoxDecoration(
                          color: Color(0xffE7EEF9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.textGray,
                          size: 26.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
