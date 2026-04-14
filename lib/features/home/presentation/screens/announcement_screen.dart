// ignore_for_file: use_build_context_synchronously
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/home/presentation/screens/full_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  VideoPlayerController? controller;

  bool isPlaying = true;
  bool showReplay = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
    );

    controller!.initialize().then((_) {
      if (mounted) {
        setState(() {});
        controller!.play();
        controller!.setLooping(false);
      }
    });

    controller!.addListener(() {
      final value = controller!.value;

      if (!value.isInitialized) return;

      if (value.position >= value.duration && !value.isPlaying) {
        setState(() {
          showReplay = true;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void togglePlay() {
    if (controller == null) return;

    setState(() {
      if (controller!.value.isPlaying) {
        controller!.pause();
        isPlaying = false;
      } else {
        controller!.play();
        isPlaying = true;
        showReplay = false;
      }
    });
  }

  void replay() {
    setState(() {
      showReplay = false;
      isPlaying = true;
    });

    controller!
      ..seekTo(Duration.zero)
      ..play();
  }

  void openFullScreen() {
    if (controller == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenVideo(controller: controller!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final videoHeight = 0.30.sh;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary, size: 28.sp),
        title: Text(
          "الإعلانات",
          style: TextStyle(fontSize: 22.sp, color: AppColors.primary),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🎬 VIDEO
            SizedBox(
              height: videoHeight,
              width: double.infinity,
              child:
                  (controller?.value.isInitialized ?? false)
                      ? GestureDetector(
                        onTap: togglePlay,
                        child: Stack(
                          children: [
                            /// 🎬 VIDEO
                            AspectRatio(
                              aspectRatio: controller!.value.aspectRatio,
                              child: VideoPlayer(controller!),
                            ),

                            /// ▶️ Play icon
                            if (!controller!.value.isPlaying)
                              const Center(
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              ),

                            /// ⛶ FULLSCREEN (كبرناها)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: IconButton(
                                icon: Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                  size: 34.sp, // 👈 كبرنا الأيقونة
                                ),
                                onPressed: openFullScreen,
                              ),
                            ),

                            /// ⏱ PROGRESS BAR داخل الفيديو
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 15.h, // 👈 ممكن تزودها لو عايز
                                decoration: const BoxDecoration(
                                  color: Colors.black26,
                                ),
                                child: VideoProgressIndicator(
                                  controller!,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                    playedColor: Colors.red,
                                    bufferedColor: Colors.grey,
                                    backgroundColor: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "برامج العام الجديد 2025",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    textAlign: TextAlign.right,
                    "نعلن عن إطلاق مجموعة جديدة من البرامج التعليمية "
                    "والتدريبية المصممة خصيصاً لتطوير مهاراتك في مختلف "
                    "المجالات التقنية والإدارية. انضم الآن وابدأ رحلتك "
                    "نحو مستقبل مهني أفضل مع خبراء المجال",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textGray,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
