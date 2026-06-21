import 'package:arabas_app/config/di/di.dart';
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
                          children: [
                            CourseVideoSection(
                              videoUrl: firstVideo?.url,
                              imageUrl: course.imageUrl,
                              offer: course.offer,
                            ),

                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      textDirection: TextDirection.ltr,
                                      course.categoryName,
                                      style: TextStyle(
                                        color: AppColors.textGray,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 6.h),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      course.title,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            TabBar(
                              labelColor: AppColors.primary,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: AppColors.primary,
                              indicatorWeight: 3,
                              tabs: const [
                                Tab(text: "الوصف"),
                                Tab(text: "المحتوى"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      CourseDescriptionTab(
                        description: course.description,
                        rateStar: course.rateStar,
                        durationHours: course.durationHours,
                      ),

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

class CourseDescriptionTab extends StatelessWidget {
  final String description;
  final int rateStar;
  final int durationHours;

  const CourseDescriptionTab({
    super.key,
    required this.description,
    required this.rateStar,
    required this.durationHours,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Html(
              data: description,
              style: {
                "body": Style(
                  textAlign: TextAlign.right,
                  fontSize: FontSize(16.sp),
                ),
              },
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                ...List.generate(
                  5,
                  (i) => Icon(
                    i < rateStar ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                ),

                const Spacer(),

                Text("$durationHours ساعة", textDirection: TextDirection.rtl),

                SizedBox(width: 6.w),
                Icon(Icons.access_time, color: AppColors.primary),
              ],
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
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      formatDuration(video.durationSeconds),
                      style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              Icon(
                locked ? Icons.lock : Icons.play_circle_fill,
                size: 28.sp,
                color: locked ? Colors.grey : AppColors.primary,
              ),
            ],
          ),
        );
      },
    );
  }
}
