import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (!mounted) return;
      final value = widget.controller.value;

      if (!value.isInitialized) return;

      if (value.position >= value.duration && !value.isPlaying) {
        setState(() {
          showReplay = true;
        });
      }
    });
  }

  void togglePlay() {
    setState(() {
      if (widget.controller.value.isPlaying) {
        widget.controller.pause();
      } else {
        widget.controller.play();
        showReplay = false;
      }
    });
  }

  void replay() {
    setState(() {
      showReplay = false;
    });

    widget.controller
      ..seekTo(Duration.zero)
      ..play();
  }

  void toggleControls() {
    setState(() {
      showControls = !showControls;
    });
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

              /// ▶️ Play icon
              if (showControls &&
                  !widget.controller.value.isPlaying &&
                  !showReplay)
                const Center(
                  child: Icon(Icons.play_arrow, size: 80, color: Colors.white),
                ),

              /// 🔄 Replay
              if (showReplay)
                Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.replay,
                      size: 80,
                      color: Colors.white,
                    ),
                    onPressed: replay,
                  ),
                ),

              /// 🔙 Back
              if (showControls)
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

              /// ⏯ Play/Pause
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
                        size: 40,
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
