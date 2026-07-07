// my_courses_tab_screen.dart

// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/core/widgets/app_primary_button.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_state.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/screens/my_certificates_screen.dart';
import 'package:arabas_app/features/my_courses/domain/entity/last_progress_entity.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/last_progress_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/last_progress_state.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_courses_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_courses_state.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/screens/my_course_details_screen.dart';
import 'package:arabas_app/features/my_courses/presentation/screens/my_video_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCoursesTabScreen extends StatelessWidget {
  const MyCoursesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MyCoursesCubit>()..getMyCourses()),

        BlocProvider(
          create: (_) => sl<LastProgressCubit>()..getLastThreeProgress(),
        ),

        BlocProvider(create: (_) => sl<BuildCertificateCubit>()),
      ],
      child: BlocListener<BuildCertificateCubit, BuildCertificateState>(
        listener: (context, state) {
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
        child: Scaffold(
          backgroundColor: const Color(0xffF7F9FF),
          appBar: AppBar(
            backgroundColor: AppColors.white,
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

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "استكمال التعلم",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 230.h,
                        child:
                            BlocBuilder<LastProgressCubit, LastProgressState>(
                              builder: (context, state) {
                                if (state is LastProgressLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state is LastProgressLoaded) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),

                                    itemCount: state.progress.length,

                                    itemBuilder: (context, index) {
                                      return ContinueLearningCard(
                                        progress: state.progress[index],
                                      );
                                    },
                                  );
                                }

                                return const SizedBox();
                              },
                            ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "الكورسات المشترك بها",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),

                        itemCount: state.courses.length,

                        itemBuilder: (context, index) {
                          final course = state.courses[index];

                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,

                              borderRadius: BorderRadius.circular(32.r),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.15),
                                  blurRadius: 12,
                                ),
                              ],
                            ),

                            child: Column(
                              children: [
                                /// TOP SECTION
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(32.r),
                                        topLeft: Radius.circular(32.r),
                                      ),

                                      child: Image.network(
                                        course.imageUrl,
                                        width: double.infinity,
                                        height: 190.h,
                                        fit: BoxFit.fill,

                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            height: 190.h,

                                            color: AppColors.lightGray
                                                .withOpacity(.2),

                                            child: Icon(
                                              Icons
                                                  .image_not_supported_outlined,

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
                                            height: 190.h,

                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 16.h,
                                      right: 90.w,

                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50.r,
                                          ),
                                          color: AppColors.white.withOpacity(
                                            0.2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${course.videoCount} فيديوهات",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 16.h,
                                      right: 16.w,

                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50.r,
                                          ),
                                          color: AppColors.white.withOpacity(
                                            0.2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${course.durationHours} ساعة",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      top: 10.h,
                                      left: 10.w,
                                      child: BlocBuilder<
                                        BuildCertificateCubit,
                                        BuildCertificateState
                                      >(
                                        builder: (context, certificateState) {
                                          final isLoading =
                                              certificateState
                                                  is BuildCertificateLoading;

                                          return PopupMenuButton<String>(
                                            color: AppColors.white,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            onSelected: (value) {
                                              if (value == "certificate") {
                                                context
                                                    .read<
                                                      BuildCertificateCubit
                                                    >()
                                                    .checkCertificate(
                                                      courseId: course.id,
                                                    );
                                              }
                                            },
                                            itemBuilder:
                                                (context) => [
                                                  PopupMenuItem<String>(
                                                    value: "certificate",
                                                    child:
                                                        isLoading
                                                            ? Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SizedBox(
                                                                  width: 16.w,
                                                                  height: 16.h,
                                                                  child: const CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 8.w,
                                                                ),
                                                                Text(
                                                                  "جاري التحميل...",
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                            : Text(
                                                              "الحصول على الشهادة",
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                  ),
                                                ],
                                            child: Container(
                                              width: 36.w,
                                              height: 36.h,
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(
                                                  .25,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.more_vert,
                                                color: AppColors.white,
                                                size: 20.sp,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 15.h),

                                /// DETAILS
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      course.title,
                                      textDirection: TextDirection.ltr,

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 15.h),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${course.progressPercent}%",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),

                                      Spacer(),
                                      Text(
                                        "إجمالي التقدم",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: LinearProgressIndicator(
                                        value: (course.progressPercent) / 100,
                                        minHeight: 12.h,
                                        backgroundColor: const Color(
                                          0xffDDE8F6,
                                        ),
                                        valueColor:
                                            const AlwaysStoppedAnimation(
                                              Color(0xff146A59),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20),

                                /// BUTTON
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: AppPrimaryButton(
                                    text: "دخول الدورة",
                                    icon: Icons.arrow_back,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => BlocProvider(
                                                create:
                                                    (_) =>
                                                        sl<
                                                          MyCourseDetailsCubit
                                                        >(),
                                                child: MyCourseDetailsScreen(
                                                  courseId: course.id,
                                                ),
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 24.h),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class ContinueLearningCard extends StatelessWidget {
  final LastProgressEntity progress;

  const ContinueLearningCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final double progressValue =
        progress.durationSeconds == 0
            ? 0
            : progress.lastPositionSeconds / progress.durationSeconds;

    return Container(
      width: 280.w,
      height: 220.h,
      margin: EdgeInsets.only(right: 20.w),

      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset.zero,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            spreadRadius: 2,
            offset: Offset.zero,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Course Title
          Text(
            progress.courseTitle,

            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              color: const Color(0xff146A59),
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 8.h),

          /// Lesson Title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              progress.lessonTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// Percent + Duration
          Row(
            children: [
              Text(
                "${progress.lastPositionSeconds}/${progress.durationSeconds} ثانية",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              Text(
                "${(progressValue * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Directionality(
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),

              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 12.h,
                backgroundColor: const Color(0xffDDE8F6),
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          AppPrimaryButton(
            text: "استكمال الدرس",
            icon: Icons.play_arrow_outlined,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (_) => sl<MyVideoDetailsCubit>(),
                        child: MyVideoDetailsScreen(
                          videoId: progress.lessonId,
                          lastPositionSeconds: progress.lastPositionSeconds,
                        ),
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
