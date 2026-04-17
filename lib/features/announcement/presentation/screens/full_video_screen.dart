import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  final VideoPlayerController controller;

  const FullScreenVideo({super.key, required this.controller});

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  bool showControls = true;
  bool showReplay = false;
  bool isVideoEnded = false; // 👈 مهم جدا

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(videoListener);
  }

  void videoListener() {
    if (!mounted) return;
    final value = widget.controller.value;
    if (!value.isInitialized) return;

    /// لما الفيديو يخلص نظهر replay مرة واحدة فقط
    if (value.position >= value.duration && !value.isPlaying && !isVideoEnded) {
      isVideoEnded = true;
      setState(() {
        showReplay = true;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(videoListener);
    super.dispose();
  }

  void togglePlay() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
      isVideoEnded = false;
      showReplay = false;
    }
    setState(() {});
  }

  void replay() async {
    isVideoEnded = false;
    showReplay = false;

    await widget.controller.seekTo(Duration.zero);
    await widget.controller.play();

    setState(() {});
  }

  void toggleControls() {
    setState(() => showControls = !showControls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: toggleControls,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
              ),

              if (showControls &&
                  !widget.controller.value.isPlaying &&
                  !showReplay)
                Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      size: 80.sp,
                      color: Colors.white,
                    ),
                    onPressed: togglePlay,
                  ),
                ),

              if (showReplay)
                Center(
                  child: IconButton(
                    icon: Icon(Icons.replay, size: 80.sp, color: Colors.white),
                    onPressed: replay,
                  ),
                ),

              if (showControls)
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

              if (showControls)
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        widget.controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                      onPressed: togglePlay,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
