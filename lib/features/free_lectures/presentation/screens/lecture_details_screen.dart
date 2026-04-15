// ignore_for_file: use_build_context_synchronously
import 'package:arabas_app/features/announcement/presentation/screens/full_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';

class LectureDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String videoUrl;

  const LectureDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  @override
  State<LectureDetailsScreen> createState() => _LectureDetailsScreenState();
}

class _LectureDetailsScreenState extends State<LectureDetailsScreen> {
  late VideoPlayerController controller;
  bool showReplay = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        controller.play();
      });

    controller.addListener(() {
      if (!controller.value.isInitialized) return;

      final value = controller.value;

      if (value.isPlaying && showReplay) {
        setState(() {
          showReplay = false;
        });
      }

      if (value.position >= value.duration && !value.isPlaying && !showReplay) {
        setState(() {
          showReplay = true;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void togglePlay() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
      setState(() {
        showReplay = false;
      });
    }
  }

  void replay() {
    controller.seekTo(Duration.zero);
    controller.play();

    setState(() {
      showReplay = false;
    });
  }

  void openFullScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenVideo(controller: controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: AppColors.primary)),
        centerTitle: true,
      ),

      body: Column(
        children: [
          /// 🎬 VIDEO
          controller.value.isInitialized
              ? GestureDetector(
                onTap: togglePlay,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),

                    /// ▶️ Play icon
                    if (!controller.value.isPlaying && !showReplay)
                      const Icon(
                        Icons.play_arrow,
                        size: 70,
                        color: Colors.white,
                      ),

                    /// 🔄 Replay icon
                    if (showReplay)
                      IconButton(
                        icon: const Icon(
                          Icons.replay,
                          size: 70,
                          color: Colors.white,
                        ),
                        onPressed: replay,
                      ),

                    /// ⛶ Fullscreen
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                        onPressed: openFullScreen,
                      ),
                    ),

                    /// ⏱ Progress bar
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        controller,
                        allowScrubbing: true,
                      ),
                    ),
                  ],
                ),
              )
              : SizedBox(
                height: 200.h,
                child: const Center(child: CircularProgressIndicator()),
              ),

          SizedBox(height: 20.h),

          /// 📝 TEXT
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(widget.description, textAlign: TextAlign.right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
