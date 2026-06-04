// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_state.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/screens/my_certificates_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<MyCourseDetailsCubit>()..getCourseDetails(courseId),
        ),

        BlocProvider(create: (_) => sl<BuildCertificateCubit>()),
      ],

      child: BlocListener<BuildCertificateCubit, BuildCertificateState>(
        listener: (context, state) {
          /// SUCCESS
          if (state is BuildCertificateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.white,
                behavior: SnackBarBehavior.floating,
                elevation: 5,

                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .40,
                  left: 20.w,
                  right: 20.w,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),

                duration: const Duration(seconds: 3),

                content: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: AppColors.primary,
                      size: 34.sp,
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "تم طلب الشهاده بنجاح",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => BlocProvider(
                          create:
                              (_) => sl<CertificateCubit>()..getCertificates(),

                          child: const MyCertificatesScreen(),
                        ),
                  ),
                );
              }
            });
          }

          /// ERROR
          if (state is BuildCertificateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.white,
                behavior: SnackBarBehavior.floating,
                elevation: 5,

                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .40,
                  left: 20.w,
                  right: 20.w,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),

                duration: const Duration(seconds: 4),

                content: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red,
                      size: 34.sp,
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      state.message,
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },

        child: Builder(
          builder: (context) {
            return Scaffold(
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
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is MyCourseDetailsError) {
                    return Center(
                      child: Text(
                        state.message,
                        textDirection: TextDirection.rtl,
                      ),
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

                              final totalVideoSeconds =
                                  video.durationMinutes * 60;

                              double progress =
                                  totalVideoSeconds == 0
                                      ? 0
                                      : video.lastPositionSeconds /
                                          totalVideoSeconds;

                              progress = progress.clamp(0.0, 1.0);

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

                                                textDirection:
                                                    TextDirection.ltr,

                                                style: TextStyle(
                                                  fontSize: 15.sp,

                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),

                                              SizedBox(height: 4.h),

                                              Text(
                                                "${video.durationMinutes} min",

                                                textDirection:
                                                    TextDirection.ltr,

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
                                            print(
                                              "🔥 Sending Progress => ${video.lastPositionSeconds}",
                                            );
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
                                                        lastPositionSeconds:
                                                            video
                                                                .lastPositionSeconds,
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

              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),

                  child:
                      BlocBuilder<BuildCertificateCubit, BuildCertificateState>(
                        builder: (context, certificateState) {
                          final isLoading =
                              certificateState is BuildCertificateLoading;

                          return SizedBox(
                            width: double.infinity,
                            height: 55.h,

                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primary,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),

                              onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                        context
                                            .read<BuildCertificateCubit>()
                                            .checkCertificate(
                                              courseId: courseId,
                                            );
                                      },

                              child:
                                  isLoading
                                      ? SizedBox(
                                        height: 24.h,
                                        width: 24.w,

                                        child: CircularProgressIndicator(
                                          color: AppColors.white,

                                          strokeWidth: 2.5,
                                        ),
                                      )
                                      : Text(
                                        "احصل علي الشهاده",

                                        style: TextStyle(
                                          color: AppColors.white,

                                          fontSize: 17.sp,

                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          );
                        },
                      ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
