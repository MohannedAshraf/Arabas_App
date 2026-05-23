// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyVideoDetailsScreen extends StatelessWidget {
  final String videoId;

  const MyVideoDetailsScreen({super.key, required this.videoId});

  bool isYoutube(String url) {
    return url.contains("youtube") || url.contains("youtu.be");
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  Future<void> openFile(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget buildVideo(String url) {
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
          height: 230.h,
          child: WebViewWidget(controller: controller),
        );
      }

      return Container(
        height: 230.h,
        alignment: Alignment.center,
        child: const Text("نوع الفيديو غير مدعوم"),
      );
    } catch (e) {
      return Container(
        height: 230.h,
        alignment: Alignment.center,
        child: const Text("حدث خطأ أثناء تشغيل الفيديو"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyVideoDetailsCubit>()..getVideoDetails(videoId),

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
              size: 22.sp,
            ),
          ),

          title: Text(
            "فيديو",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),

        body: BlocBuilder<MyVideoDetailsCubit, MyVideoDetailsState>(
          builder: (context, state) {
            if (state is MyVideoDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is MyVideoDetailsError) {
              return Center(
                child: Text(state.message, textDirection: TextDirection.rtl),
              );
            }

            if (state is MyVideoDetailsSuccess) {
              final video = state.video;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// VIDEO
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),

                      child: buildVideo(video.url),
                    ),

                    SizedBox(height: 10.h),

                    /// TITLE
                    Text(
                      video.title,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,

                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    /// COURSE TITLE

                    /// DURATION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: AppColors.primary,
                          size: 24.sp,
                        ),
                        SizedBox(width: 6.w),

                        Text(
                          formatDuration(video.durationSeconds),

                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    /// DESCRIPTION
                    Html(
                      data: video.description,

                      style: {
                        "html": Style(
                          direction: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),

                        "body": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                          direction: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          color: AppColors.textGray,
                          fontSize: FontSize(15.sp),
                          lineHeight: LineHeight(1.8),
                        ),

                        "div": Style(
                          direction: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),

                        "p": Style(
                          direction: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                      },
                    ),
                    if (video.files.isNotEmpty) ...[
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "الملفات",

                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      ...video.files.map(
                        (file) => Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(14.w),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),

                            border: Border.all(
                              color: AppColors.primary.withOpacity(.15),
                            ),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                Icons.insert_drive_file_rounded,
                                color: AppColors.primary,
                                size: 26.sp,
                              ),

                              SizedBox(width: 10.w),

                              Expanded(
                                child: Text(
                                  file.title,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () => openFile(file.url),

                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 8.h,
                                  ),

                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),

                                  child: Text(
                                    "فتح",
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
                        ),
                      ),
                    ],
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
