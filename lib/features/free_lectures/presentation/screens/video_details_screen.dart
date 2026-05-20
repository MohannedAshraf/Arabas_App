// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/video_details_cubit.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/video_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pod_player/pod_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  PodPlayerController? podController;
  YoutubePlayerController? youtubeController;
  WebViewController? webController;

  bool isYoutube = false;
  bool isMp4 = false;
  bool isIframe = false;

  bool isPlayerReady = false;

  Key playerKey = UniqueKey();

  /// =========================
  /// Stop Videos
  /// =========================

  void stopAllVideos() {
    youtubeController?.pause();
    podController?.pause();
  }

  @override
  void dispose() {
    stopAllVideos();

    youtubeController?.dispose();
    podController?.dispose();

    super.dispose();
  }

  /// =========================
  /// Reset Players
  /// =========================

  Future<void> resetPlayers() async {
    stopAllVideos();

    youtubeController?.dispose();
    youtubeController = null;

    podController?.dispose();
    podController = null;

    webController = null;

    isYoutube = false;
    isMp4 = false;
    isIframe = false;

    isPlayerReady = false;
  }

  /// =========================
  /// Vimeo Convert
  /// =========================

  String convertVimeoUrl(String url) {
    final uri = Uri.parse(url);
    final id = uri.pathSegments.last;

    return "https://player.vimeo.com/video/$id";
  }

  /// =========================
  /// Init Video
  /// =========================

  Future<void> initVideo(String url) async {
    await resetPlayers();

    await Future.delayed(const Duration(milliseconds: 200));

    if (!mounted) return;

    playerKey = UniqueKey();

    /// YOUTUBE
    if (url.contains("youtube.com") || url.contains("youtu.be")) {
      isYoutube = true;

      final id = YoutubePlayer.convertUrlToId(url)!;

      youtubeController = YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          controlsVisibleAtStart: true,
        ),
      );
    }
    /// MP4
    else if (url.contains(".mp4")) {
      isMp4 = true;

      podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(url),
      );

      await podController!.initialise();
    }
    /// VIMEO
    else {
      isIframe = true;

      final vimeoUrl = convertVimeoUrl(url);

      webController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(vimeoUrl));
    }

    if (mounted) {
      setState(() {
        isPlayerReady = true;
      });
    }
  }

  /// =========================
  /// Video Widget
  /// =========================

  Widget videoWidget() {
    if (!isPlayerReady) {
      return SizedBox(
        height: 220.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    Widget child;

    if (isYoutube && youtubeController != null) {
      child = YoutubePlayer(key: playerKey, controller: youtubeController!);
    } else if (isMp4 && podController != null) {
      child = PodVideoPlayer(key: playerKey, controller: podController!);
    } else if (isIframe && webController != null) {
      child = WebViewWidget(key: playerKey, controller: webController!);
    } else {
      return SizedBox(height: 220.h);
    }

    return AspectRatio(aspectRatio: 16 / 9, child: child);
  }

  @override
  void initState() {
    super.initState();

    context.read<VideoPlayerCubit>().fetchVideo(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        stopAllVideos();
        return true;
      },

      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.white,

          leading: const BackButton(color: AppColors.primary),

          title: Text(
            "الفيديو",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: BlocConsumer<VideoPlayerCubit, VideoPlayerState>(
          listener: (context, state) {
            if (state is VideoLoaded) {
              initVideo(state.video.videoUrl);
            }
          },

          builder: (context, state) {
            if (state is VideoLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VideoError) {
              return Center(
                child: Text(state.message, style: TextStyle(fontSize: 14.sp)),
              );
            }

            if (state is VideoLoaded) {
              final video = state.video;

              return ListView(
                padding: EdgeInsets.only(bottom: 25.h),

                children: [
                  /// =========================
                  /// VIDEO
                  /// =========================
                  Container(
                    margin: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: videoWidget(),
                    ),
                  ),

                  /// =========================
                  /// TITLE
                  /// =========================
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),

                    child: Text(
                      video.title,
                      textDirection: TextDirection.rtl,

                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  /// =========================
                  /// DESCRIPTION
                  /// =========================
                  if (video.description != null &&
                      video.description!.trim().isNotEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),

                      padding: EdgeInsets.all(16.w),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),

                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Html(
                          data: video.description,

                          style: {
                            "*": Style(
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              textAlign: TextAlign.right,
                              lineHeight: LineHeight(1.4),
                              color: AppColors.textGray,
                              fontSize: FontSize(14.sp),
                            ),

                            "ul": Style(listStyleType: ListStyleType.none),

                            "ol": Style(listStyleType: ListStyleType.none),

                            "li": Style(display: Display.inline),

                            "p": Style(display: Display.inline),

                            "div": Style(display: Display.inline),

                            "span": Style(display: Display.inline),

                            "br": Style(display: Display.none),
                          },
                        ),
                      ),
                    ),

                  SizedBox(height: 20.h),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
