// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/widgets/subscribe_button.dart';
import 'package:arabas_app/features/courses/domain/entities/course_details_entity.dart';
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

            if (state is CourseDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is CourseDetailsSuccess) {
              final course = state.course;

              final validVideos =
                  course.videos.where((e) => e.url != null).toList();

              final firstVideo =
                  validVideos.isNotEmpty ? validVideos.first : null;

              return DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// الفيديو (سيبه كما هو)
                            CourseVideoSection(
                              videoUrl: firstVideo?.url,
                              imageUrl: course.imageUrl,
                              offer: course.offer,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 16.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Badge
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7A3556),
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Text(
                                        course.categoryName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  /// Title
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      course.title,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 15.h),

                                  Row(
                                    children: [
                                      Text(
                                        "${course.durationHours} ساعة",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Icon(
                                        Icons.access_time,
                                        size: 18.sp,
                                        color: AppColors.black,
                                      ),

                                      const Spacer(),

                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            index < course.rateStar
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: AppColors.primary,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20.h),

                                  Container(
                                    height: 64.h,

                                    padding: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffEEF3FF),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: TabBar(
                                      dividerColor: Colors.transparent,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicator: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              .08,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      labelColor: const Color(0xff6A244A),
                                      unselectedLabelColor: const Color(
                                        0xff5B4D57,
                                      ),
                                      labelStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      unselectedLabelStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      splashFactory: NoSplash.splashFactory,
                                      overlayColor: WidgetStateProperty.all(
                                        Colors.transparent,
                                      ),
                                      tabs: const [
                                        Tab(text: "الوصف"),
                                        Tab(text: "المحتوى"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      CourseDescriptionTab(description: course.description),

                      CourseContentTab(videos: course.videos),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        bottomNavigationBar:
            BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
              builder: (context, state) {
                if (state is! CourseDetailsSuccess) return const SizedBox();

                final course = state.course;

                return SubscribeButton(
                  price: course.priceInEGP.toDouble(),
                  onPressed: () {
                    // هنضيف الأكشن بعدين
                  },
                );
              },
            ),
      ),
    );
  }
}

class CourseVideoSection extends StatelessWidget {
  final String? videoUrl;
  final String? imageUrl;
  final int offer;

  const CourseVideoSection({
    super.key,
    required this.videoUrl,
    required this.imageUrl,
    required this.offer,
  });

  Widget _buildVideo() {
    if (videoUrl == null || videoUrl!.isEmpty) {
      return Image.network(
        imageUrl ?? "",
        width: double.infinity,
        height: 250.h,
        fit: BoxFit.cover,
      );
    }

    /// YOUTUBE
    if (videoUrl!.contains("youtube") || videoUrl!.contains("youtu.be")) {
      final videoId = YoutubePlayer.convertUrlToId(videoUrl!);

      if (videoId == null) {
        return const SizedBox();
      }

      return YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, forceHD: true),
        ),
        showVideoProgressIndicator: true,
      );
    }

    /// VIMEO
    if (videoUrl!.contains("vimeo")) {
      final uri = Uri.parse(videoUrl!);

      final videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : "";

      final embedUrl =
          "https://player.vimeo.com/video/$videoId?title=0&byline=0&portrait=0";

      final controller =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(embedUrl));

      return SizedBox(
        height: 250.h,
        width: double.infinity,
        child: WebViewWidget(controller: controller),
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: double.infinity, height: 250.h, child: _buildVideo()),

        Positioned(
          top: 20.h,
          left: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              "خصم $offer%",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CourseDescriptionTab extends StatefulWidget {
  final String description;

  const CourseDescriptionTab({super.key, required this.description});

  @override
  State<CourseDescriptionTab> createState() => _CourseDescriptionTabState();
}

class _CourseDescriptionTabState extends State<CourseDescriptionTab> {
  bool isExpanded = false;

  String getShortText(String html) {
    final text = html.replaceAll(RegExp(r'<[^>]*>'), '');

    if (text.length <= 180) return html;

    return "${text.substring(0, 180)}...";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.only(
          right: 15.w,
          top: 20.h,
          bottom: 15.h,
          left: 15.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 14.sp,
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

class CourseContentTab extends StatelessWidget {
  final List<CourseVideoEntity> videos;

  const CourseContentTab({super.key, required this.videos});

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;

    return "$minutes:${remaining.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      itemCount: videos.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, i) {
        final video = videos[i];

        final locked = video.url == null;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${i + 1}. ${video.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Text(
                      formatDuration(video.durationSeconds),
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),

              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color:
                      locked
                          ? Color(0XFFDCEAFA)
                          : const Color(0xff7A3B5C).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  locked ? Icons.lock_outline : Icons.play_arrow,
                  color: locked ? Color(0XFF514349) : AppColors.primary,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
