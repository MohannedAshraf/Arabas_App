// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_video_entity.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_video_cubit.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_video_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';

import 'package:arabas_app/features/my_courses/presentation/bloc/progress_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyDiplomaVideoScreen extends StatelessWidget {
  final String videoId;

  /// آخر ثانية متشافة علشان يكمل منها
  final int lastPositionSeconds;

  const MyDiplomaVideoScreen({
    super.key,
    required this.videoId,
    this.lastPositionSeconds = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyDiplomaVideoCubit>()..getVideo(videoId),

      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,

          iconTheme: const IconThemeData(color: AppColors.primary),

          title: Text(
            "الفيديو",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 19.sp,
            ),
          ),
        ),

        body: BlocBuilder<MyDiplomaVideoCubit, MyDiplomaVideoState>(
          builder: (context, state) {
            if (state is MyDiplomaVideoLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is MyDiplomaVideoError) {
              return Center(child: Text(state.message));
            }

            if (state is MyDiplomaVideoSuccess) {
              final video = state.video;

              return DefaultTabController(
                length: 3,

                child: Column(
                  children: [
                    ///==========================
                    /// Video Player
                    ///==========================
                    DiplomaVideoPlayerSection(
                      video: video.currentVideo,
                      lastPositionSeconds: lastPositionSeconds,
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            SizedBox(height: 18.h),

                            Text(
                              video.currentVideo.title,
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),

                            SizedBox(height: 22.h),

                            TabBar(
                              dividerColor: Colors.transparent,

                              indicatorColor: AppColors.primary,

                              indicatorWeight: 3,

                              indicatorSize: TabBarIndicatorSize.label,

                              labelColor: AppColors.primary,

                              unselectedLabelColor: AppColors.textGray,

                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),

                              unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),

                              tabs: const [
                                Tab(text: "الوصف"),
                                Tab(text: "الملفات"),
                                Tab(text: "الكويزات"),
                              ],
                            ),

                            SizedBox(height: 15.h),

                            Expanded(
                              child: TabBarView(
                                children: [
                                  /// Description
                                  DescriptionTab(
                                    description: video.currentVideo.description,
                                  ),

                                  /// Files
                                  FilesTab(files: video.currentVideo.files),

                                  /// Quizzes
                                  QuizzesTab(
                                    quizzes: video.currentVideo.quizzes,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

class DiplomaVideoPlayerSection extends StatefulWidget {
  final CurrentVideoEntity video;
  final int lastPositionSeconds;

  const DiplomaVideoPlayerSection({
    super.key,
    required this.video,
    required this.lastPositionSeconds,
  });

  @override
  State<DiplomaVideoPlayerSection> createState() =>
      _DiplomaVideoPlayerSectionState();
}

class _DiplomaVideoPlayerSectionState extends State<DiplomaVideoPlayerSection>
    with WidgetsBindingObserver {
  YoutubePlayerController? youtubeController;

  WebViewController? vimeoController;

  Timer? progressTimer;

  int currentSeconds = 0;
  int lastSentPosition = -1;
  int videoDuration = 0;

  bool youtubeTrackingStarted = false;
  bool vimeoTrackingStarted = false;

  bool youtubeSeekDone = false;
  bool vimeoSeekDone = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    videoDuration = widget.video.durationSeconds;
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

    if (videoDuration > 0 && currentSeconds >= (videoDuration * .99)) {
      currentSeconds = videoDuration;
    }

    if (currentSeconds == lastSentPosition) {
      return;
    }

    lastSentPosition = currentSeconds;

    try {
      await sl<ProgressCubit>().trackProgress(
        lessonId: widget.video.id,
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
typeof window.player.getCurrentTime==='function'){

window.player.getCurrentTime().then(function(seconds){

ProgressChannel.postMessage(
"TIME_"+seconds
);

});

}
''');

      await Future.delayed(const Duration(seconds: 2));

      await sendProgress();
    });
  }

  Widget buildVideo() {
    final url = widget.video.url;

    try {
      ///======================
      /// Youtube
      ///======================

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

          if (!youtubeTrackingStarted) {
            youtubeTrackingStarted = true;

            startYoutubeTracking();
          }
        }

        return YoutubePlayer(
          controller: youtubeController!,
          showVideoProgressIndicator: true,
        );
      }

      ///======================
      /// Vimeo
      ///======================

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
"ENDED_"+duration.toString()
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

var script=document.createElement('script');

script.src="https://player.vimeo.com/api/player.js";

document.head.appendChild(script);

script.onload=function(){

var iframe=document.getElementById('player');

if(!iframe){
return;
}

window.player=new Vimeo.Player(iframe);

window.player.ready().then(function(){

window.player.setCurrentTime(
${widget.lastPositionSeconds}
);

});

window.player.on(
'timeupdate',
function(data){

ProgressChannel.postMessage(
"TIME_"+data.seconds
);

});

window.player.on(
'ended',
function(){

ProgressChannel.postMessage(
"VIDEO_ENDED"
);

});

};
''');

                    currentSeconds = widget.lastPositionSeconds;

                    if (!vimeoTrackingStarted) {
                      vimeoTrackingStarted = true;

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
    return WillPopScope(
      onWillPop: () async {
        await sendProgress();
        return true;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),

            ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: buildVideo(),
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class DescriptionTab extends StatefulWidget {
  final String description;

  const DescriptionTab({super.key, required this.description});

  @override
  State<DescriptionTab> createState() => _DescriptionTabState();
}

class _DescriptionTabState extends State<DescriptionTab> {
  bool isExpanded = false;

  String getShortText(String html) {
    final plainText = html.replaceAll(RegExp(r'<[^>]*>'), '');

    if (plainText.length <= 500) {
      return html;
    }

    return "${plainText.substring(0, 500)}...";
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 20.h),

      children: [
        Container(
          width: double.infinity,

          padding: EdgeInsets.only(
            right: 16.w,
            left: 16.w,
            top: 20.h,
            bottom: 18.h,
          ),

          decoration: BoxDecoration(
            color: AppColors.white,

            borderRadius: BorderRadius.circular(18.r),

            border: Border.all(color: Colors.grey.shade200),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                "وصف الدرس",
                textDirection: TextDirection.rtl,

                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),

              SizedBox(height: 16.h),

              Html(
                data:
                    isExpanded
                        ? widget.description
                        : getShortText(widget.description),

                style: {
                  "*": Style(
                    direction: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    color: AppColors.textGray,
                    fontSize: FontSize(14.sp),
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
      ],
    );
  }
}

class FilesTab extends StatelessWidget {
  final List<VideoFileEntity> files;

  const FilesTab({super.key, required this.files});

  String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return "$bytes B";
    }

    if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(1)} KB";
    }

    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  }

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) {
      return Center(
        child: Text(
          "لا توجد ملفات",
          style: TextStyle(color: AppColors.textGray, fontSize: 16.sp),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20.h),

      itemCount: files.length,

      separatorBuilder: (_, __) => SizedBox(height: 14.h),

      itemBuilder: (context, index) {
        final file = files[index];

        return InkWell(
          borderRadius: BorderRadius.circular(18.r),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => PdfViewerScreen(
                      pdfUrl: file.fileUrl,
                      title: file.fileName,
                    ),
              ),
            );
          },

          child: Container(
            padding: EdgeInsets.all(16.w),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(18.r),

              border: Border.all(color: Colors.grey.shade200),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  width: 52.w,
                  height: 52.w,

                  decoration: BoxDecoration(
                    color: const Color(0xffffe8f0),

                    borderRadius: BorderRadius.circular(14.r),
                  ),

                  child: Icon(
                    Icons.picture_as_pdf_rounded,
                    color: AppColors.primary,
                    size: 28.sp,
                  ),
                ),

                SizedBox(width: 16.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        file.fileName,

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        formatFileSize(file.fileSize),

                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

        iconTheme: const IconThemeData(color: Colors.black),

        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black),
        ),
      ),

      body: SfPdfViewer.network(pdfUrl),
    );
  }
}

class QuizzesTab extends StatelessWidget {
  final List<VideoQuizEntity> quizzes;

  const QuizzesTab({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    if (quizzes.isEmpty) {
      return Center(
        child: Text(
          "لا توجد اختبارات",
          style: TextStyle(color: AppColors.textGray, fontSize: 16.sp),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20.h),

      itemCount: quizzes.length,

      separatorBuilder: (_, __) => SizedBox(height: 14.h),

      itemBuilder: (context, index) {
        final quiz = quizzes[index];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(18.r),

            border: Border.all(color: Colors.grey.shade200),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            children: [
              /// زرار البداية
              ElevatedButton(
                onPressed: () {
                  /// Navigate To Quiz Screen
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),

                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                ),

                child: Text(
                  "ابدأ الاختبار",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Text(
                  quiz.title,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
              ),

              SizedBox(width: 14.w),

              Container(
                width: 54.w,
                height: 54.w,

                decoration: BoxDecoration(
                  color: const Color(0xffF7E8EF),
                  borderRadius: BorderRadius.circular(14.r),
                ),

                child: Icon(
                  Icons.quiz_rounded,
                  color: AppColors.primary,
                  size: 28.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
