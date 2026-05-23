// my_courses_tab_screen.dart

// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_courses_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_courses_state.dart';
import 'package:arabas_app/features/my_courses/presentation/screens/my_course_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCoursesTabScreen extends StatelessWidget {
  const MyCoursesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyCoursesCubit>()..getMyCourses(),

      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,

          title: Text(
            "دوراتي",
            textDirection: TextDirection.rtl,

            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
        ),

        body: BlocBuilder<MyCoursesCubit, MyCoursesState>(
          builder: (context, state) {
            /// LOADING
            if (state is MyCoursesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            /// ERROR
            if (state is MyCoursesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.primary,
                      size: 70.sp,
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      state.message,
                      textDirection: TextDirection.rtl,

                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),

                      onPressed: () {
                        context.read<MyCoursesCubit>().getMyCourses();
                      },

                      child: Text(
                        "إعادة المحاولة",
                        textDirection: TextDirection.rtl,

                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            /// SUCCESS
            if (state is MyCoursesLoaded) {
              if (state.courses.isEmpty) {
                return Center(
                  child: Text(
                    "لا يوجد كورسات حاليا",
                    textDirection: TextDirection.rtl,

                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 16.sp,
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),

                itemCount: state.courses.length,

                separatorBuilder: (_, __) => SizedBox(height: 18.h),

                itemBuilder: (context, index) {
                  final course = state.courses[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,

                      borderRadius: BorderRadius.circular(22.r),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),
                          blurRadius: 12,
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: EdgeInsets.all(12.w),

                      child: Column(
                        children: [
                          /// TOP SECTION
                          Row(
                            textDirection: TextDirection.ltr,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              /// IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18.r),

                                child: Image.network(
                                  course.imageUrl,
                                  width: 120.w,
                                  height: 110.h,
                                  fit: BoxFit.cover,

                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 120.w,
                                      height: 110.h,

                                      color: AppColors.lightGray.withOpacity(
                                        .2,
                                      ),

                                      child: Icon(
                                        Icons.image_not_supported_outlined,

                                        color: AppColors.textGray,

                                        size: 35.sp,
                                      ),
                                    );
                                  },

                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }

                                    return SizedBox(
                                      width: 120.w,
                                      height: 135.h,

                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(width: 14.w),

                              /// DETAILS
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,

                                  children: [
                                    /// TITLE
                                    Text(
                                      course.title,
                                      textDirection: TextDirection.ltr,

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                        height: 1.5,
                                      ),
                                    ),

                                    SizedBox(height: 10.h),

                                    /// VIDEOS + HOURS
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        _buildInfoItem(
                                          icon:
                                              Icons.play_circle_outline_rounded,

                                          text: "${course.videoCount} فيديو",
                                        ),

                                        _buildInfoItem(
                                          icon: Icons.access_time_rounded,

                                          text: "${course.durationHours} ساعة",
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10.h),

                                    /// RATING
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,

                                      children: List.generate(
                                        5,
                                        (starIndex) => Icon(
                                          starIndex < course.rateStar
                                              ? Icons.star_rounded
                                              : Icons.star_border_rounded,

                                          color: Colors.amber,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8.h),

                          /// BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 48.h,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),

                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BlocProvider(
                                          create:
                                              (_) => sl<MyCourseDetailsCubit>(),
                                          child: MyCourseDetailsScreen(
                                            courseId: course.id,
                                          ),
                                        ),
                                  ),
                                );
                              },

                              child: Text(
                                "الدخول للكورس",
                                textDirection: TextDirection.rtl,

                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildInfoItem({required IconData icon, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Text(
          text,
          textDirection: TextDirection.rtl,

          style: TextStyle(
            color: AppColors.textGray,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(width: 4.w),

        Icon(icon, color: AppColors.primary, size: 18.sp),
      ],
    );
  }
}
