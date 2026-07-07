// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/core/widgets/app_primary_button.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_state.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/screens/my_certificates_screen.dart';
import 'package:arabas_app/features/my_courses/domain/entity/progress_in_course_entity.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_state.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/progress_in_course_state.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/progrress_in_course_cubit.dart';
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

        BlocProvider(
          create:
              (_) =>
                  sl<ProgressInCourseCubit>()
                    ..getProgressInCourse(courseId: courseId),
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

                    return DefaultTabController(
                      length: 2,
                      initialIndex: 1,
                      child: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    height: 250.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.r),
                                      image: DecorationImage(
                                        image: NetworkImage(course.imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            course.title,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 20.h),
                                        BlocBuilder<
                                          ProgressInCourseCubit,
                                          ProgressInCourseState
                                        >(
                                          builder: (context, progressState) {
                                            if (progressState
                                                    is ProgressInCourseSuccess &&
                                                progressState
                                                    .progress
                                                    .isNotEmpty) {
                                              return Column(
                                                children: [
                                                  QuickContinueCard(
                                                    lesson:
                                                        progressState
                                                            .progress
                                                            .first,
                                                    onContinue: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                _,
                                                              ) => BlocProvider(
                                                                create:
                                                                    (_) =>
                                                                        sl<
                                                                          MyVideoDetailsCubit
                                                                        >(),
                                                                child: MyVideoDetailsScreen(
                                                                  videoId:
                                                                      progressState
                                                                          .progress
                                                                          .first
                                                                          .lessonId,
                                                                  lastPositionSeconds:
                                                                      progressState
                                                                          .progress
                                                                          .first
                                                                          .lastPositionSeconds,
                                                                ),
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                  SizedBox(height: 20.h),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "تقدمك الاخير  ",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                        color: AppColors.black,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(height: 20.h),

                                                  ProgressSummaryList(
                                                    lessons:
                                                        progressState.progress,
                                                  ),
                                                ],
                                              );
                                            }

                                            return const SizedBox();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    child: Container(
                                      height: 72.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEDF4FF),
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(6.w),
                                      child: TabBar(
                                        dividerColor: Colors.transparent,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicator: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                .08,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),

                                        labelColor: AppColors.primary,
                                        unselectedLabelColor: const Color(
                                          0xff8E8893,
                                        ),

                                        labelStyle: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),

                                        unselectedLabelStyle: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),

                                        tabs: const [
                                          Tab(text: "عن  الدورة"),
                                          Tab(text: "المنهج"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },

                        body: TabBarView(
                          children: [
                            MyCourseDescriptionTab(
                              description: course.description,
                            ),

                            MyCourseContentTab(videos: course.videos),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyCourseDescriptionTab extends StatefulWidget {
  final String description;

  const MyCourseDescriptionTab({super.key, required this.description});

  @override
  State<MyCourseDescriptionTab> createState() => _MyCourseDescriptionTabState();
}

class _MyCourseDescriptionTabState extends State<MyCourseDescriptionTab> {
  bool isExpanded = false;

  String getShortText(String html) {
    final plainText = html.replaceAll(RegExp(r'<[^>]*>'), '');

    if (plainText.length <= 500) return html;

    return "${plainText.substring(0, 500)}...";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10.h),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            padding: EdgeInsets.only(
              right: 15.w,
              top: 20.h,
              bottom: 10.h,
              left: 10.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "عن الكورس",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                Html(
                  data:
                      isExpanded
                          ? widget.description
                          : getShortText(widget.description),
                  style: {
                    "*": Style(
                      direction: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      fontSize: FontSize(14.sp),
                      color: AppColors.textGray,
                      lineHeight: LineHeight(1.8),
                    ),
                  },
                ),

                SizedBox(height: 8.h),

                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isExpanded ? "عرض أقل" : "عرض المزيد",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class MyCourseContentTab extends StatelessWidget {
  final List videos;

  const MyCourseContentTab({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: videos.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, i) {
        final video = videos[i];

        final totalVideoSeconds = video.durationMinutes * 60;

        final bool isCompleted =
            video.lastPositionSeconds >= totalVideoSeconds &&
            totalVideoSeconds > 0;

        final double progress =
            totalVideoSeconds == 0
                ? 0
                : (video.lastPositionSeconds / totalVideoSeconds).clamp(
                  0.0,
                  1.0,
                );

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(22.r),
            border:
                isCompleted
                    ? Border(
                      right: BorderSide(
                        color: const Color(0xff146A59),
                        width: 5.w,
                      ),
                    )
                    : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// أيقونة التشغيل / الاكتمال (يمين الكارد)

              /// المحتوى
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// الصف الأول
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isCompleted
                              ? "${video.durationMinutes} دقائق"
                              : "${video.lastPositionSeconds}/$totalVideoSeconds ثانية",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 13.sp,
                          ),
                        ),

                        Text(
                          "الدرس ${i + 1}",
                          style: TextStyle(
                            color:
                                isCompleted
                                    ? const Color(0xff146A59)
                                    : Colors.grey,
                            fontSize: 12.sp,
                            fontWeight:
                                isCompleted
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    /// العنوان
                    Text(
                      video.title,
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// البار يظهر فقط لو الفيديو غير مكتمل
                    if (!isCompleted) ...[
                      SizedBox(height: 12.h),

                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6.h,
                            backgroundColor: const Color(0xffDDE8F9),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xffB59AC6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(width: 20.w),

              InkWell(
                onTap:
                    isCompleted
                        ? null
                        : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider(
                                    create: (_) => sl<MyVideoDetailsCubit>(),
                                    child: MyVideoDetailsScreen(
                                      videoId: video.id,
                                      lastPositionSeconds:
                                          video.lastPositionSeconds,
                                    ),
                                  ),
                            ),
                          );
                        },
                child: Container(
                  width: 54.w,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color:
                        isCompleted
                            ? const Color(0xffE6F4F1)
                            : const Color(0xffDDE8F9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check_circle_outline_rounded
                        : Icons.play_arrow_outlined,
                    color:
                        isCompleted
                            ? const Color(0xff146A59)
                            : AppColors.primary,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuickContinueCard extends StatelessWidget {
  final ProgressInCourseEntity lesson;
  final VoidCallback onContinue;

  const QuickContinueCard({
    super.key,
    required this.lesson,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        lesson.durationSeconds == 0
            ? 0.0
            : lesson.lastPositionSeconds / lesson.durationSeconds;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black12,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF4EDF2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_circle_outline,
                  color: AppColors.primary,
                  size: 36.sp,
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "آخر ما تمت مشاهدته",
                      style: TextStyle(
                        color: AppColors.primary.withOpacity(.7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        lesson.lessonTitle,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Row(
            children: [
              Text(
                "${lesson.durationSeconds} ثانية",
                textDirection: TextDirection.rtl,
                style: TextStyle(color: AppColors.textGray, fontSize: 14.sp),
              ),

              const Spacer(),

              Text(
                "${lesson.lastPositionSeconds} ثانية",
                textDirection: TextDirection.rtl,
                style: TextStyle(color: AppColors.textGray, fontSize: 14.sp),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Directionality(
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 10.h,
                backgroundColor: const Color(0xffD9E8FB),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),

          SizedBox(height: 22.h),

          AppPrimaryButton(
            text: "متابعة الدرس",
            icon: Icons.arrow_back,
            onPressed: onContinue,
          ),
          //
          // ====================================================
        ],
      ),
    );
  }
}

class ProgressSummaryCard extends StatelessWidget {
  final ProgressInCourseEntity lesson;

  const ProgressSummaryCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final percent =
        lesson.watchPercent == 0
            ? ((lesson.lastPositionSeconds / lesson.durationSeconds) * 100)
                .round()
                .clamp(0, 100)
            : lesson.watchPercent;

    return Container(
      width: 240.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xffEDF4FF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              lesson.lessonTitle,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "تمت المشاهدة",
                  style: TextStyle(color: AppColors.textGray, fontSize: 15.sp),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xff0B7A69),
                      width: 8,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$percent%",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
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

class ProgressSummaryList extends StatelessWidget {
  final List<ProgressInCourseEntity> lessons;

  const ProgressSummaryList({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: lessons.length,
        separatorBuilder: (_, __) => SizedBox(width: 14.w),
        itemBuilder: (_, index) {
          return ProgressSummaryCard(lesson: lessons[index]);
        },
      ),
    );
  }
}
