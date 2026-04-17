// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:arabas_app/core/constants/app_images.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/announcement/presentation/screens/full_video_screen.dart';
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

  bool isPlaying = false;
  bool showReplay = false;

  final List<Map<String, String>> ads = [
    {
      "title": "آفاق طب الأعصاب",
      "desc": "أحدث الأبحاث في رسم التشابكات العصبية وتجديد الخلايا العصبية",
    },
    {
      "title": "الجراحة الحديثة",
      "desc": "تقنيات متقدمة في العمليات الدقيقة باستخدام أحدث الأجهزة",
    },
    {
      "title": "طب القلب المتقدم",
      "desc": "تطورات تشخيص وعلاج أمراض القلب بأحدث الوسائل",
    },
  ];

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
        controller!.setLooping(false);
        isPlaying = false;
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
    if (controller == null || !controller!.value.isInitialized) return;

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
    controller!
      ..seekTo(Duration.zero)
      ..play();

    setState(() {
      showReplay = false;
      isPlaying = true;
    });
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: SizedBox(
                  height: videoHeight,
                  width: double.infinity,
                  child:
                      (controller?.value.isInitialized ?? false)
                          ? GestureDetector(
                            onTap: togglePlay,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AspectRatio(
                                  aspectRatio: controller!.value.aspectRatio,
                                  child: VideoPlayer(controller!),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.45),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),

                                if (!controller!.value.isPlaying)
                                  Center(
                                    child: GestureDetector(
                                      onTap: showReplay ? replay : togglePlay,
                                      child: Container(
                                        width: 75.w,
                                        height: 75.w,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          showReplay
                                              ? Icons.replay
                                              : Icons.play_arrow,
                                          size: 48.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      size: 34.sp,
                                    ),
                                    onPressed: openFullScreen,
                                  ),
                                ),

                                /// Progress bar
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 14.h,
                                    color: Colors.black26,
                                    child: VideoProgressIndicator(
                                      controller!,
                                      allowScrubbing: true,
                                      colors: const VideoProgressColors(
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
              ),
            ),

            SizedBox(height: 25.h),

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

                  SizedBox(height: 5.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "مشاركة",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "تصفح المزيد",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  SizedBox(
                    height: 260.h,
                    child: ListView.separated(
                      reverse: true,
                      scrollDirection: Axis.horizontal,

                      itemCount: ads.length,
                      separatorBuilder: (_, __) => SizedBox(width: 14.w),
                      itemBuilder: (context, index) {
                        final item = ads[index];
                        return _adCard(item);
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adCard(Map<String, String> item) {
    return Container(
      width: 220.w,
      height: 2000,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: Image.asset(
                  AppImages.eye,
                  height: 130.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// NEW ARRIVAL badge
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "جديد",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item["title"]!,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  item["desc"]!,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 5.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 16.sp,
                      color: AppColors.primary,
                    ),
                    Text(
                      "مجلة",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
