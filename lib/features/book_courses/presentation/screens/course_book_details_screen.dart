// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pod_player/pod_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/course_book_details_cubit.dart';
import '../bloc/course_book_details_state.dart';

class CourseBookDetailsScreen extends StatefulWidget {
  final String courseId;
  const CourseBookDetailsScreen({super.key, required this.courseId});

  @override
  State<CourseBookDetailsScreen> createState() =>
      _CourseBookDetailsScreenState();
}

class _CourseBookDetailsScreenState extends State<CourseBookDetailsScreen> {
  PodPlayerController? podController;
  YoutubePlayerController? youtubeController;
  WebViewController? webController;

  bool isYoutube = false;
  bool isMp4 = false;
  bool isIframe = false;

  /// 🔥 الجديد لحل المشكلة
  bool isPlayerReady = false;
  String? currentVideoUrl;

  Key playerKey = UniqueKey();

  /// 🔥 ايقاف كل الفيديوهات
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

  /// 🔥 reset آمن بدون WebView crash
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

    /// مهم جداً
    isPlayerReady = false;
    currentVideoUrl = null;
  }

  String convertVimeoUrl(String url) {
    final uri = Uri.parse(url);
    final id = uri.pathSegments.last;
    return "https://player.vimeo.com/video/$id";
  }

  /// 🔥 تشغيل الفيديو (بعد الإصلاح)
  Future<void> initVideo(String url) async {
    await resetPlayers();

    /// مهم جداً لتفادي crash
    await Future.delayed(const Duration(milliseconds: 200));

    if (!mounted) return;

    setState(() {
      isPlayerReady = false;
      currentVideoUrl = null;
    });

    playerKey = UniqueKey();

    if (url.contains("youtube.com") || url.contains("youtu.be")) {
      isYoutube = true;

      final id = YoutubePlayer.convertUrlToId(url)!;

      youtubeController = YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          controlsVisibleAtStart: true,
        ),
      );
    } else if (url.contains(".mp4")) {
      isMp4 = true;

      podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(url),
      );

      await podController!.initialise();
    } else {
      isIframe = true;

      final vimeoUrl = convertVimeoUrl(url);

      webController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(vimeoUrl));

      currentVideoUrl = vimeoUrl;
    }

    if (mounted) {
      setState(() {
        isPlayerReady = true;
      });
    }
  }

  Widget videoWidget() {
    /// 🔥 الحماية الأساسية
    if (!isPlayerReady) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
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
      return const SizedBox(height: 220);
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: GestureDetector(
        onTap: () {
          if (isYoutube) {
            youtubeController!.value.isPlaying
                ? youtubeController!.pause()
                : youtubeController!.play();
          } else if (isMp4) {
            podController!.isVideoPlaying
                ? podController!.pause()
                : podController!.play();
          }
        },
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        stopAllVideos();
        return true;
      },
      child: BlocProvider(
        create:
            (_) => CourseBookDetailsCubit(sl())..getDetails(widget.courseId),
        child: BlocListener<CourseBookDetailsCubit, CourseBookDetailsState>(
          listener: (context, state) {
            if (state is DetailsLoaded) {
              final video = state.data.chapters[state.selectedVideoIndex];
              initVideo(video.url);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackButton(color: AppColors.primary),
              title: const Text(
                "تفاصيل كورس الكتاب",
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            body: BlocBuilder<CourseBookDetailsCubit, CourseBookDetailsState>(
              builder: (context, state) {
                if (state is DetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DetailsError) {
                  return Center(child: Text(state.message));
                }

                if (state is DetailsLoaded) {
                  final course = state.data;
                  final selectedIndex = state.selectedVideoIndex;

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: videoWidget(),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        course.title,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14),
                          const SizedBox(width: 6),
                          Text(course.createdAt.split("T").first),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// وصف كنص فقط بدون أي تنسيق
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Html(
                          data: course.description,
                          style: {
                            "*": Style(
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              textAlign: TextAlign.right,
                              lineHeight: LineHeight(1.4),
                              color: AppColors.textGray,
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

                      const SizedBox(height: 20),

                      const Text(
                        "الفيديوهات",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ListView.builder(
                        itemCount: course.chapters.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final video = course.chapters[index];
                          final isSelected = index == selectedIndex;

                          return InkWell(
                            onTap: () {
                              context
                                  .read<CourseBookDetailsCubit>()
                                  .changeVideo(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColors.primary.withOpacity(.1)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? AppColors.primary
                                          : Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      video.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            isSelected
                                                ? AppColors.primary
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.play_circle_fill,
                                    color:
                                        isSelected
                                            ? AppColors.primary
                                            : Colors.grey,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
