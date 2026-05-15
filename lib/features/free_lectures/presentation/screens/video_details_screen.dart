import 'package:arabas_app/features/free_lectures/presentation/bloc/video_details_cubit.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/video_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../core/theme/app_colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? controller;
  bool isPlaying = true;
  bool showPauseIcon = false;
  bool isFinished = false;

  String getYoutubeId(String url) => url.split("youtu.be/").last;

  void initPlayer(String url) {
    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        //  autoPlay: true,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    controller!.loadVideoById(videoId: getYoutubeId(url));
  }

  void togglePlayPause() {
    if (isPlaying) {
      controller!.pauseVideo();
      showPauseIcon = true;
    } else {
      controller!.playVideo();
      showPauseIcon = false;
    }
    setState(() => isPlaying = !isPlaying);
  }

  void replay() {
    controller!.seekTo(seconds: 0);
    controller!.playVideo();
    setState(() => isFinished = false);
  }

  @override
  void initState() {
    super.initState();
    context.read<VideoPlayerCubit>().fetchVideo(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.primary,
        title: const Text("الفيديو"),
      ),
      body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VideoError) {
            return Center(child: Text(state.message));
          }

          if (state is VideoLoaded) {
            initPlayer(state.video.videoUrl);

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: togglePlayPause,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        YoutubePlayer(controller: controller!),

                        if (showPauseIcon)
                          const Icon(Icons.pause_circle, size: 70),

                        if (isFinished)
                          IconButton(
                            icon: const Icon(Icons.replay, size: 70),
                            onPressed: replay,
                          ),

                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: IconButton(
                            icon: const Icon(Icons.fullscreen),
                            onPressed: () {
                              // NAVIGATE FULLSCREEN LATER
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      state.video.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (state.video.description != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Html(data: state.video.description!),
                    ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
