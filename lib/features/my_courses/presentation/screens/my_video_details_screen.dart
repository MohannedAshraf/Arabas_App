// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_courses/domain/entity/my_video_details_entity.dart';
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
  final int lastPositionSeconds;

  const MyVideoDetailsScreen({
    super.key,
    required this.videoId,
    required this.lastPositionSeconds,
  });

  @override
  State<MyVideoDetailsScreen> createState() => _MyVideoDetailsScreenState();
}

class _MyVideoDetailsScreenState extends State<MyVideoDetailsScreen>
    with WidgetsBindingObserver {
  YoutubePlayerController? youtubeController;

  WebViewController? vimeoController;

  Timer? progressTimer;

  int currentSeconds = 0;
  int lastSentPosition = -1;
  int _videoDuration = 0;

  bool isYoutubeTrackingStarted = false;
  bool isVimeoTrackingStarted = false;

  bool youtubeSeekDone = false;
  bool vimeoSeekDone = false;

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    sendProgress();

    progressTimer?.cancel();

    youtubeController?.dispose();

    vimeoController = null;

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      sendProgress();
    }
  }

  Future<void> sendProgress() async {
    if (currentSeconds <= 0) return;

    if (_videoDuration > 0 && currentSeconds >= (_videoDuration * 0.99)) {
      currentSeconds = _videoDuration;
    }

    if (currentSeconds == lastSentPosition) return;

    lastSentPosition = currentSeconds;

    try {
      await sl<ProgressCubit>().trackProgress(
        lessonId: widget.videoId,
        positionSeconds: currentSeconds,
      );
    } catch (_) {}
  }

  void startYoutubeTracking() {
    progressTimer?.cancel();

    progressTimer = Timer.periodic(const Duration(seconds: 15), (_) async {
      if (youtubeController != null) {
        currentSeconds = youtubeController!.value.position.inSeconds;

        await sendProgress();
      }
    });
  }

  void startVimeoTracking(WebViewController controller) {
    progressTimer?.cancel();

    progressTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      await controller.runJavaScript('''

if(window.player &&
   typeof window.player.getCurrentTime === 'function') {

window.player.getCurrentTime().then(function(seconds){

ProgressChannel.postMessage(
"TIME_" + seconds
);

});

}
''');

      await Future.delayed(const Duration(seconds: 2));

      await sendProgress();
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
      /// YOUTUBE
      if (url.contains("youtube") || url.contains("youtu.be")) {
        final id = YoutubePlayer.convertUrlToId(url);

        if (id == null) {
          return const SizedBox();
        }

        if (youtubeController == null) {
          youtubeController = YoutubePlayerController(
            initialVideoId: id,
            flags: const YoutubePlayerFlags(autoPlay: false),
          );

          youtubeController!.addListener(() async {
            if (youtubeController!.value.isReady) {
              currentSeconds = youtubeController!.value.position.inSeconds;

              if (youtubeController!.value.playerState == PlayerState.ended) {
                currentSeconds = youtubeController!.metadata.duration.inSeconds;

                await sendProgress();
              }

              if (!youtubeSeekDone && widget.lastPositionSeconds > 0) {
                youtubeSeekDone = true;

                youtubeController!.seekTo(
                  Duration(seconds: widget.lastPositionSeconds),
                );

                currentSeconds = widget.lastPositionSeconds;
              }
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

      /// VIMEO
      if (url.contains("vimeo")) {
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
                  if (message.message == "VIDEO_ENDED") {
                    await vimeoController?.runJavaScript('''

if(window.player){

player.getDuration().then(function(duration){

ProgressChannel.postMessage(
"ENDED_" + duration.toString()
);

});

}
''');

                    return;
                  }

                  if (message.message.startsWith("ENDED_")) {
                    currentSeconds =
                        double.parse(
                          message.message.replaceFirst("ENDED_", ""),
                        ).toInt();

                    await sendProgress();

                    return;
                  }

                  if (message.message.startsWith("TIME_")) {
                    currentSeconds =
                        double.parse(
                          message.message.replaceFirst("TIME_", ""),
                        ).round();
                  }
                },
              )
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageFinished: (_) async {
                    await vimeoController!.runJavaScript('''

var script = document.createElement('script');
script.src = "https://player.vimeo.com/api/player.js";

document.head.appendChild(script);

script.onload = function() {

var iframe =
document.getElementById('player');

if(!iframe){
return;
}

window.player =
new Vimeo.Player(iframe);

window.player.ready()
.then(function() {

window.player.setCurrentTime(
${widget.lastPositionSeconds}
);

});

window.player.on(
'timeupdate',
function(data) {

ProgressChannel.postMessage(
"TIME_" + data.seconds
);

});

window.player.on(
'ended',
function() {

ProgressChannel.postMessage(
"VIDEO_ENDED"
);

});

};
''');

                    currentSeconds = widget.lastPositionSeconds;

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
src="$embedUrl#t=${widget.lastPositionSeconds}s"
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
    } catch (_) {
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
              _videoDuration = video.durationSeconds;
              return WillPopScope(
                onWillPop: () async {
                  await sendProgress();
                  return true;
                },

                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),

                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18.r),
                        child: buildVideo(video.url),
                      ),

                      SizedBox(height: 20.h),

                      VideoTabsSection(
                        video: video,
                        lastPositionSeconds: widget.lastPositionSeconds,
                        onOpenFile: openFile,
                      ),

                      SizedBox(height: 30.h),
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

class VideoTabsSection extends StatelessWidget {
  final MyVideoDetailsEntity video;
  final int lastPositionSeconds;
  final Future<void> Function(String url) onOpenFile;

  const VideoTabsSection({
    super.key,
    required this.video,
    required this.lastPositionSeconds,
    required this.onOpenFile,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,

            child: Container(
              width: 220.w,
              height: 46.h,

              decoration: BoxDecoration(
                color: const Color(0xffE9EEF6),
                borderRadius: BorderRadius.circular(16.r),
              ),

              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,

                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 8,
                    ),
                  ],
                ),

                labelColor: const Color(0xff7D365B),
                unselectedLabelColor: const Color(0xff687790),

                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),

                tabs: const [Tab(text: "نظرة عامة"), Tab(text: "المصادر")],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          SizedBox(
            height: 650.h,

            child: TabBarView(
              children: [
                OverviewTab(video: video),

                ResourcesTab(
                  video: video,
                  lastPositionSeconds: lastPositionSeconds,
                  onOpenFile: onOpenFile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  final MyVideoDetailsEntity video;

  const OverviewTab({super.key, required this.video});

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remain = seconds % 60;

    return "$minutes:${remain.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            video.title,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,

            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),

          SizedBox(height: 10.h),

          Align(
            alignment: Alignment.centerRight,

            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  formatDuration(video.durationSeconds),

                  style: TextStyle(
                    color: AppColors.textGray,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
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
          ),

          SizedBox(height: 15.h),

          ExpandableDescription(description: video.description),
        ],
      ),
    );
  }
}

class ExpandableDescription extends StatefulWidget {
  final String description;

  const ExpandableDescription({super.key, required this.description});

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(16.w),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16.r),

        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black12,
            offset: Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "وصف الدرس",
              textAlign: TextAlign.right,

              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          Html(
            data: '''
<div dir="rtl">
${widget.description}
</div>
''',

            style: {
              "*": Style(
                direction: TextDirection.rtl,

                textAlign: TextAlign.right,

                color: AppColors.textGray,

                fontSize: FontSize(14.sp),

                lineHeight: LineHeight(1.8),

                maxLines: expanded ? null : 7,

                textOverflow: TextOverflow.ellipsis,
              ),
            },
          ),

          SizedBox(height: 10.h),

          InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },

            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                expanded ? "عرض أقل" : "عرض المزيد",

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
    );
  }
}

class ResourcesTab extends StatelessWidget {
  final MyVideoDetailsEntity video;

  final int lastPositionSeconds;

  final Future<void> Function(String url) onOpenFile;

  const ResourcesTab({
    super.key,
    required this.video,
    required this.lastPositionSeconds,
    required this.onOpenFile,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        video.durationSeconds == 0
            ? 0.0
            : ((lastPositionSeconds / video.durationSeconds) * 100).clamp(
              0,
              100,
            );

    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "المصادر والملفات",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          if (video.files.isNotEmpty)
            ListView.builder(
              itemCount: video.files.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final file = video.files[index];

                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(16.r),

                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black12,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),

                  child: ListTile(
                    title: Text(
                      file.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(file.size?.toString() ?? ""),

                    trailing: InkWell(
                      borderRadius: BorderRadius.circular(12.r),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => PdfViewerScreen(
                                  pdfUrl: file.url,
                                  title: file.title,
                                ),
                          ),
                        );
                      },

                      child: Container(
                        padding: EdgeInsets.all(10.r),

                        decoration: BoxDecoration(
                          color: const Color(0XFFFFD8E8),

                          borderRadius: BorderRadius.circular(12.r),
                        ),

                        child: Icon(
                          Icons.insert_drive_file_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          SizedBox(height: 20.h),

          LessonProgressCard(progress: progress.toDouble()),
        ],
      ),
    );
  }
}

class LessonProgressCard extends StatelessWidget {
  final double progress;

  const LessonProgressCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(vertical: 24.h),

      decoration: BoxDecoration(
        color: const Color(0xffEEF3FB),

        borderRadius: BorderRadius.circular(20.r),
      ),

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تقدمك في الدرس",

                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),
          SizedBox(
            width: 100.w,
            height: 100.w,

            child: Stack(
              alignment: Alignment.center,

              children: [
                SizedBox(
                  width: 90.w,
                  height: 90.w,

                  child: CircularProgressIndicator(
                    value: progress / 100,

                    strokeWidth: 8,

                    color: AppColors.green,
                  ),
                ),

                Text(
                  "${progress.toInt()}%",

                  style: TextStyle(
                    color: AppColors.primary,

                    fontWeight: FontWeight.bold,

                    fontSize: 20.sp,
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

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;
  final String title;

  const PdfViewerScreen({super.key, required this.pdfUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black),
        ),

        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
