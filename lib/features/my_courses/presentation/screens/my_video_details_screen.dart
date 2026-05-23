// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_state.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/progress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoDetailsScreen extends StatefulWidget {
  final String videoId;

  const MyVideoDetailsScreen({super.key, required this.videoId});

  @override
  State<MyVideoDetailsScreen> createState() => _MyVideoDetailsScreenState();
}

class _MyVideoDetailsScreenState extends State<MyVideoDetailsScreen>
    with WidgetsBindingObserver {
  YoutubePlayerController? youtubeController;

  WebViewController? vimeoController;

  Timer? progressTimer;

  int currentSeconds = 0;

  bool isYoutubeTrackingStarted = false;

  bool isVimeoTrackingStarted = false;

  bool isYoutube(String url) {
    return url.contains("youtube") || url.contains("youtu.be");
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    print("✅ Video Screen Initialized");
  }

  @override
  void dispose() {
    print("🛑 SCREEN DISPOSED");

    sendProgress();

    progressTimer?.cancel();

    youtubeController?.dispose();

    vimeoController = null;

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  /// لما التطبيق يروح background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("📱 App Lifecycle State => $state");

    if (state == AppLifecycleState.paused) {
      sendProgress();
    }
  }

  Future<void> sendProgress() async {
    print("🚀 SEND PROGRESS CALLED");

    if (currentSeconds <= 0) {
      print("⚠️ currentSeconds = 0");

      return;
    }

    try {
      await sl<ProgressCubit>().trackProgress(
        lessonId: widget.videoId,
        positionSeconds: currentSeconds,
      );

      print(
        "✅ Progress Sent Successfully => lessonId: ${widget.videoId} | seconds: $currentSeconds",
      );
    } catch (e) {
      print("❌ Progress Error => $e");
    }
  }

  /// =========================
  /// YOUTUBE TRACKING
  /// =========================
  void startYoutubeTracking() {
    print("⏱ START YOUTUBE TRACKING");

    progressTimer?.cancel();

    progressTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (youtubeController != null) {
        currentSeconds = youtubeController!.value.position.inSeconds;

        print("🎥 Youtube Position => $currentSeconds sec");

        await sendProgress();
      }
    });
  }

  /// =========================
  /// VIMEO TRACKING
  /// =========================
  void startVimeoTracking(WebViewController controller) {
    print("⏱ START VIMEO TRACKING");

    progressTimer?.cancel();

    progressTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      try {
        await controller.runJavaScript('''
            player.getCurrentTime().then(function(seconds) {
              ProgressChannel.postMessage(
                seconds.toString()
              );
            });
          ''');
      } catch (e) {
        print("❌ Vimeo Tracking Error => $e");
      }
    });
  }

  Future<void> openFile(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget buildVideo(String url) {
    try {
      /// =========================
      /// YOUTUBE
      /// =========================
      if (url.contains("youtube") || url.contains("youtu.be")) {
        final id = YoutubePlayer.convertUrlToId(url);

        if (id == null) {
          print("❌ Invalid Youtube URL");

          return const SizedBox();
        }

        if (youtubeController == null) {
          youtubeController = YoutubePlayerController(
            initialVideoId: id,
            flags: const YoutubePlayerFlags(autoPlay: false),
          );

          print("✅ Youtube Controller Created");

          youtubeController!.addListener(() {
            if (youtubeController!.value.isReady) {
              currentSeconds = youtubeController!.value.position.inSeconds;
            }
          });

          if (!isYoutubeTrackingStarted) {
            isYoutubeTrackingStarted = true;

            startYoutubeTracking();
          }
        }

        return YoutubePlayer(
          controller: youtubeController!,
          showVideoProgressIndicator: true,
        );
      }

      /// =========================
      /// VIMEO
      /// =========================
      if (url.contains("vimeo")) {
        print("🔥 VIMEO VIDEO DETECTED");

        final uri = Uri.parse(url);

        final videoId =
            uri.pathSegments.isNotEmpty ? uri.pathSegments.last : "";

        final embedUrl =
            "https://player.vimeo.com/video/$videoId?api=1&player_id=player";

        vimeoController ??=
            WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..addJavaScriptChannel(
                "ProgressChannel",

                onMessageReceived: (message) async {
                  currentSeconds =
                      double.tryParse(message.message)?.toInt() ?? 0;

                  print("🎥 Vimeo Position => $currentSeconds sec");

                  await sendProgress();
                },
              )
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageFinished: (_) async {
                    print("✅ Vimeo Loaded");

                    await vimeoController!.runJavaScript('''

                      var script = document.createElement('script');

                      script.src =
                      "https://player.vimeo.com/api/player.js";

                      document.head.appendChild(script);

                      script.onload = function() {

                        var iframe =
                        document.querySelector('iframe');

                        window.player =
                        new Vimeo.Player(iframe);

                      };

                    ''');

                    if (!isVimeoTrackingStarted) {
                      isVimeoTrackingStarted = true;

                      startVimeoTracking(vimeoController!);
                    }
                  },
                ),
              )
              ..loadHtmlString('''
<!DOCTYPE html>

<html>

<body style="margin:0;padding:0;">

<iframe
  id="player"
  src="$embedUrl"
  width="100%"
  height="230"
  frameborder="0"
  allow="autoplay; fullscreen"
  allowfullscreen>
</iframe>

</body>

</html>
''');

        return SizedBox(
          height: 230.h,
          child: WebViewWidget(controller: vimeoController!),
        );
      }

      return Container(
        height: 230.h,
        alignment: Alignment.center,
        child: const Text("نوع الفيديو غير مدعوم"),
      );
    } catch (e) {
      print("❌ VIDEO ERROR => $e");

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
      create: (_) => sl<MyVideoDetailsCubit>()..getVideoDetails(widget.videoId),

      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,

          leading: IconButton(
            onPressed: () async {
              print("⬅️ BACK BUTTON CLICKED");

              await sendProgress();

              if (mounted) {
                Navigator.pop(context);
              }
            },

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

              return WillPopScope(
                onWillPop: () async {
                  print("🔙 SYSTEM BACK PRESSED");

                  await sendProgress();

                  return true;
                },

                child: SingleChildScrollView(
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

                      /// DURATION
                      Row(
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
                        data: '''
<div dir="rtl" style="text-align:right;">
${video.description}
</div>
''',

                        style: {
                          "*": Style(
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

                          "body": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            direction: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        },
                      ),
                    ],
                  ),
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
