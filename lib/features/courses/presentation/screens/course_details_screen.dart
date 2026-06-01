import 'package:arabas_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/course_details_cubit.dart';
import '../bloc/course_details_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseId;

  const CourseDetailsScreen({super.key, required this.courseId});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  PodPlayerController? controller;
  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  bool isYoutube(String url) {
    return url.contains("youtube") || url.contains("youtu.be");
  }

  Widget buildVideo(String? url, String? imageUrl) {
    if (url == null || url.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.sp),
        child: Image.network(
          imageUrl ?? "",
          height: 220.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    try {
      /// YOUTUBE
      if (url.contains("youtube") || url.contains("youtu.be")) {
        final videoId = YoutubePlayer.convertUrlToId(url);

        if (videoId == null) {
          return const SizedBox();
        }

        return YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false),
          ),
          showVideoProgressIndicator: true,
        );
      }

      /// VIMEO
      if (url.contains("vimeo")) {
        final uri = Uri.parse(url);

        final videoId =
            uri.pathSegments.isNotEmpty ? uri.pathSegments.last : "";

        final embedUrl = "https://player.vimeo.com/video/$videoId";

        final controller =
            WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse(embedUrl));

        return SizedBox(
          height: 220.h,
          child: WebViewWidget(controller: controller),
        );
      }

      return Container(
        height: 220.h,
        alignment: Alignment.center,
        child: const Text("نوع الفيديو غير مدعوم"),
      );
    } catch (e) {
      return Container(
        height: 220.h,
        alignment: Alignment.center,
        child: const Text("حدث خطأ أثناء تشغيل الفيديو"),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => sl<CourseDetailsCubit>()..getCourseDetails(widget.courseId),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "تفاصيل الكورس",
            style: TextStyle(color: AppColors.primary),
          ),
          leading: const BackButton(color: AppColors.primary),
        ),
        body: BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
          builder: (context, state) {
            if (state is CourseDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CourseDetailsSuccess) {
              final course = state.course;

              final validVideos =
                  course.videos.where((e) => e.url != null).toList();

              final firstVideo =
                  validVideos.isNotEmpty ? validVideos.first : null;

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// VIDEO PLAYER
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: buildVideo(firstVideo?.url, course.imageUrl),
                        ),
                        Positioned(
                          top: 15.h,
                          left: 10.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(30.sp),
                            ),
                            child: Text(
                              textDirection: TextDirection.rtl,
                              "خصم ${course.offer}%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// CATEGORY
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        course.categoryName,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 6.h),

                    /// TITLE
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        course.title,
                        textDirection: TextDirection.ltr,

                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    /// DESCRIPTION
                    Html(
                      data: course.description,

                      style: {
                        "body": Style(
                          textAlign: TextAlign.right,
                          fontSize: FontSize(16.sp),
                          color: AppColors.black,
                        ),
                      },
                    ),

                    SizedBox(height: 15.h),

                    /// RATE + DURATION
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            i < course.rateStar
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          "${course.durationHours} ساعة",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    /// CONTENT TITLE
                    Text(
                      "المحتوى",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15.h),

                    /// VIDEOS LIST
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: course.videos.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (_, i) {
                        final video = course.videos[i];
                        final locked = video.url == null;

                        final duration = formatDuration(video.durationSeconds);

                        return Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 6,
                                color: Colors.black12,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              /// TEXTS (LEFT SIDE)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video.title,
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp,
                                      ),
                                    ),

                                    SizedBox(height: 4.h),

                                    Text(
                                      duration,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 12.w),

                              /// ICON (RIGHT SIDE)
                              Icon(
                                locked ? Icons.lock : Icons.play_circle_fill,
                                size: 28,
                                color: locked ? Colors.grey : AppColors.primary,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            if (state is CourseDetailsError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),

        bottomNavigationBar:
            BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
              builder: (context, state) {
                if (state is! CourseDetailsSuccess) return const SizedBox();

                final course = state.course;

                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.sp),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black26,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${course.priceInEGP} جنيه",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 12.w),
                          Text(
                            "اشترك الآن",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
