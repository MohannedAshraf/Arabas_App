// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_state.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/screens/my_video_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCourseDetailsScreen extends StatelessWidget {
  final String courseId;

  const MyCourseDetailsScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyCourseDetailsCubit>()..getCourseDetails(courseId),

      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,

          leading: IconButton(
            onPressed: () => Navigator.pop(context),

            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
            ),
          ),

          title: Text(
            "تفاصيل الكورس",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),

        body: BlocBuilder<MyCourseDetailsCubit, MyCourseDetailsState>(
          builder: (context, state) {
            if (state is MyCourseDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is MyCourseDetailsError) {
              return Center(
                child: Text(state.message, textDirection: TextDirection.rtl),
              );
            }

            if (state is MyCourseDetailsSuccess) {
              final course = state.course;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),

                      child: Image.network(
                        course.imageUrl,
                        width: double.infinity,
                        height: 220.h,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 18.h),

                    /// TITLE
                    Text(
                      course.title,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,

                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    /// DESCRIPTION
                    Html(
                      data: course.description,

                      style: {
                        "body": Style(
                          color: AppColors.textGray,
                          fontSize: FontSize(15.sp),
                          lineHeight: LineHeight(1.7),
                          textAlign: TextAlign.right,
                        ),
                      },
                    ),

                    SizedBox(height: 10.h),

                    /// RATE + HOURS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < course.rateStars
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,

                              color: Colors.amber,
                              size: 22.sp,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              "${course.durationHours} ساعة",
                              textDirection: TextDirection.rtl,

                              style: TextStyle(
                                color: AppColors.textGray,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.access_time_filled_rounded,
                              color: AppColors.primary,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    /// CONTENT TITLE
                    Text(
                      "المحتوى",
                      textDirection: TextDirection.rtl,

                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    /// VIDEOS
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: course.videos.length,

                      separatorBuilder: (_, __) => SizedBox(height: 12.h),

                      itemBuilder: (_, i) {
                        final video = course.videos[i];

                        double progress =
                            video.durationMinutes == 0
                                ? 0
                                : video.lastPositionMinutes /
                                    video.durationMinutes;

                        return Container(
                          padding: EdgeInsets.all(14.w),

                          decoration: BoxDecoration(
                            color: AppColors.white,

                            borderRadius: BorderRadius.circular(16.r),

                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                color: Colors.black12,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          video.title,
                                          textDirection: TextDirection.ltr,

                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        SizedBox(height: 4.h),

                                        Text(
                                          "${video.durationMinutes} min",
                                          textDirection: TextDirection.ltr,

                                          style: TextStyle(
                                            color: AppColors.textGray,

                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 12.w),

                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => BlocProvider(
                                                create:
                                                    (_) =>
                                                        sl<
                                                          MyVideoDetailsCubit
                                                        >(),
                                                child: MyVideoDetailsScreen(
                                                  videoId: video.id,
                                                ),
                                              ),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.play_circle_fill_rounded,
                                      color: AppColors.primary,
                                      size: 32.sp,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 14.h),

                              /// PROGRESS
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),

                                child: LinearProgressIndicator(
                                  value: progress,

                                  minHeight: 8.h,

                                  backgroundColor: AppColors.lightGray
                                      .withOpacity(.3),

                                  valueColor: AlwaysStoppedAnimation(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 10.h),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
