// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/core/widgets/subscribe_button.dart';
import 'package:arabas_app/features/diplomas/domain/entities/diploma_details_entity.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DiplomaDetailsScreen extends StatefulWidget {
  final String diplomaId;

  const DiplomaDetailsScreen({super.key, required this.diplomaId});

  @override
  State<DiplomaDetailsScreen> createState() => _DiplomaDetailsScreenState();
}

class _DiplomaDetailsScreenState extends State<DiplomaDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  /// 🔥 NEW: short text helper
  // String _getShortText(String html) {
  //   final plainText = html.replaceAll(RegExp(r'<[^>]*>'), '');

  //   if (plainText.length <= 120) return html;

  //   final short = plainText.substring(0, 120);

  //   return "$short...";
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "تفاصيل الدورة",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),

      body: BlocBuilder<DiplomaDetailsCubit, DiplomaDetailsState>(
        builder: (context, state) {
          if (state is DiplomaDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DiplomaDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is DiplomaDetailsLoaded) {
            final diploma = state.diploma;

            return NestedScrollView(
              headerSliverBuilder:
                  (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: DiplomaHeaderSection(
                        imageUrl: diploma.imageUrl,
                        title: diploma.title,
                        price: diploma.priceInEGP,
                        durationHours: diploma.durationHours,
                        controller: _tabController,
                      ),
                    ),
                  ],
              body: Column(
                children: [
                  SizedBox(height: 20.h),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        DiplomaDescriptionTab(
                          description: diploma.description,
                          isExpanded: isExpanded,
                          studentsInTrainingImages:
                              diploma.studentsInTrainingImages,
                          onToggle: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),

                        DiplomaContentTab(
                          modules: diploma.modules,
                          formatDuration: formatDuration,
                        ),

                        DiplomaCertificatesTab(
                          certificates: diploma.certificateImages,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),

      bottomNavigationBar:
          BlocBuilder<DiplomaDetailsCubit, DiplomaDetailsState>(
            builder: (context, state) {
              if (state is DiplomaDetailsLoaded) {
                return SubscribeButton(price: state.diploma.priceInEGP);
              }

              return const SizedBox();
            },
          ),
    );
  }
}

class DiplomaHeaderSection extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int durationHours;
  final TabController controller;

  const DiplomaHeaderSection({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.durationHours,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: 270.h,
            fit: BoxFit.fill,
          ),
        ),

        SizedBox(height: 15.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),

              // SizedBox(height: 15.h),

              // Row(
              //   children: [
              //     Icon(Icons.schedule, color: AppColors.primary, size: 18.sp),

              //     SizedBox(width: 5.w),

              //     Text(
              //       "$durationHours ساعة",
              //       textDirection: TextDirection.rtl,
              //       style: TextStyle(fontSize: 13.sp),
              //     ),

              //     const Spacer(),

              //     Text(
              //       "$price جنيه",
              //       textDirection: TextDirection.rtl,
              //       style: TextStyle(
              //         fontSize: 15.sp,
              //         color: AppColors.primary,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 20.h),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TabBar(
                      controller: controller,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,

                      labelColor: AppColors.primary,
                      unselectedLabelColor: const Color(0xff5A4A4F),

                      indicatorColor: AppColors.primary,
                      indicatorWeight: 4,
                      indicatorSize: TabBarIndicatorSize.label,

                      dividerColor: Colors.transparent,

                      labelPadding: EdgeInsets.only(
                        left: 20.w, // المسافة بين التابات
                      ),

                      tabs: const [
                        Tab(text: "الوصف"),
                        Tab(text: "المحتوى"),
                        Tab(text: "الشهادات"),
                      ],
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

class BottomPriceBar extends StatelessWidget {
  final double price;

  const BottomPriceBar({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: SizedBox(
        height: 55.h,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${price.toStringAsFixed(0)} جنيه",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.w),

              Text(
                "سجل الآن",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiplomaDescriptionTab extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<StudentTrainingImageEntity> studentsInTrainingImages;

  const DiplomaDescriptionTab({
    super.key,
    required this.description,
    required this.isExpanded,
    required this.onToggle,
    required this.studentsInTrainingImages,
  });

  String getShortText(String html) {
    final plainText = html.replaceAll(RegExp(r'<[^>]*>'), '');

    if (plainText.length <= 500) return html;

    return "${plainText.substring(0, 500)}...";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10.h),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            padding: EdgeInsets.only(
              right: 15.w,
              top: 20.h,
              bottom: 10.h,
              left: 10.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),

            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "عن الدبلومة ",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(height: 15.h),
                Html(
                  data: isExpanded ? description : getShortText(description),
                  style: {
                    "*": Style(
                      direction: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      fontSize: FontSize(14.sp),
                      color: AppColors.textGray,
                      lineHeight: LineHeight(1.8),
                    ),
                  },
                ),

                SizedBox(height: 8.h),

                InkWell(
                  onTap: onToggle,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isExpanded ? "عرض أقل" : "عرض المزيد",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "الطلاب أثناء  التدريب",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          if (studentsInTrainingImages.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: List.generate(
                  (studentsInTrainingImages.length / 2).ceil(),
                  (index) {
                    final first = index * 2;
                    final second = first + 1;

                    // آخر صورة فقط
                    if (second >= studentsInTrainingImages.length) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.network(
                            studentsInTrainingImages[first].url,
                            width: double.infinity,
                            height: 260.h,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;

                              return Container(
                                height: 260.h,
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 260.h,
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }

                    // صورتين جنب بعض
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.network(
                                studentsInTrainingImages[first].url,
                                height: 170.h,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;

                                  return Container(
                                    height: 170.h,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 170.h,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(width: 10.w),

                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.network(
                                studentsInTrainingImages[second].url,
                                height: 170.h,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;

                                  return Container(
                                    height: 170.h,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 170.h,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 10.h),
          ],

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class DiplomaContentTab extends StatelessWidget {
  final List<ModuleEntity> modules;
  final String Function(int) formatDuration;

  const DiplomaContentTab({
    super.key,
    required this.modules,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    if (modules.isEmpty) {
      return const Center(child: Text("No Content"));
    }

    final firstModule = modules.first;

    final VideoEntity? firstVideo =
        firstModule.videos.isNotEmpty ? firstModule.videos.first : null;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      children: [
        if (firstVideo != null && firstVideo.videoUrl.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: DiplomaPreviewVideo(videoUrl: firstVideo.videoUrl),
          ),

          SizedBox(height: 20.h),
        ],

        ...List.generate(modules.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: ModuleCard(
              module: modules[index],
              moduleIndex: index,
              formatDuration: formatDuration,
            ),
          );
        }),
      ],
    );
  }
}

class DiplomaPreviewVideo extends StatelessWidget {
  final String videoUrl;

  const DiplomaPreviewVideo({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        height: 220.h,
        width: double.infinity,
        child: _buildVideo(),
      ),
    );
  }

  Widget _buildVideo() {
    /// Youtube
    if (videoUrl.contains("youtube") || videoUrl.contains("youtu.be")) {
      final videoId = YoutubePlayer.convertUrlToId(videoUrl);

      if (videoId == null) {
        return const SizedBox();
      }

      return YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, forceHD: true),
        ),
        showVideoProgressIndicator: true,
      );
    }

    /// Vimeo
    if (videoUrl.contains("vimeo")) {
      final uri = Uri.parse(videoUrl);

      final videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : "";

      final embedUrl =
          "https://player.vimeo.com/video/$videoId?title=0&byline=0&portrait=0";

      final controller =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(embedUrl));

      return WebViewWidget(controller: controller);
    }

    return const Center(child: Text("نوع الفيديو غير مدعوم"));
  }
}

class DiplomaCertificatesTab extends StatelessWidget {
  final List certificates;

  const DiplomaCertificatesTab({super.key, required this.certificates});

  @override
  Widget build(BuildContext context) {
    if (certificates.isEmpty) {
      return const Center(child: Text("لا توجد شهادات"));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Center(
              child: Text(
                "مسارك المهني يبدأ بوثيقه معتمدة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                "احصل علي شهادة مهنية تعزز من فرصك الوظيفية وتثبت جدارتك في سوق العمل العالمي",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textGray),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),

                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          color: Color(0xff5F2444).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            "المستوي الأساسي",
                            style: TextStyle(
                              color: Color(0XFF5F2444).withOpacity(0.6),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color(0xFFEDF4FF),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.workspace_premium,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      textDirection: TextDirection.rtl,
                      "شهادة المؤسسة العربية للتعليم",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      textDirection: TextDirection.rtl,
                      "شهادة إتمام مجانية تصدر من المؤسسة العربية للتعليم والتدريب فور الإنتهاء من  متطلبات الدبلومة",
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 14.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.done,
                              color: AppColors.white,
                              size: 10.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          textDirection: TextDirection.rtl,
                          "مشمولة مجاناً مع الدورة",
                          style: TextStyle(
                            color: Colors.green,

                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),

            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          color: Color(0xff146A59).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            "اعتماد دولي",
                            style: TextStyle(
                              color: Color(0XFF146A59),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color(0xFFA4F2DB),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.security,
                            color: AppColors.greenDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      textDirection: TextDirection.rtl,
                      "اعتماد الهيئة الدولية البريطانية (CPD)",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      textDirection: TextDirection.rtl,
                      "شهادة التطوير المهني المستمر المعتمدة من بؤيطانيا, تمنحك اعترافاً مهنياً واسع النطاق عالمياً",
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 14.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: AppColors.white,
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: AppColors.primary,
                              size: 10.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          textDirection: TextDirection.rtl,
                          "رسوم إضافية إختيارية",
                          style: TextStyle(
                            color: AppColors.primary,

                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "معاينة الشهادات",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 15.h),

            SizedBox(
              height: 220.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: certificates.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final certificate = certificates[index];

                  return Container(
                    width: 300.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.grey.shade200,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      certificate.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class ModuleCard extends StatefulWidget {
  final ModuleEntity module;
  final int moduleIndex;
  final String Function(int) formatDuration;

  const ModuleCard({
    super.key,
    required this.module,
    required this.moduleIndex,
    required this.formatDuration,
  });

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },

          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),

          childrenPadding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
          ),

          iconColor: AppColors.primary,
          collapsedIconColor: Colors.grey.shade700,

          title: Row(
            children: [
              Expanded(
                child: Text(
                  widget.module.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isExpanded ? 12.sp : 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2D2D2D),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Container(
                width: 42.w,
                height: 42.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      isExpanded ? AppColors.primary : const Color(0xffE8EEF9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  (widget.moduleIndex + 1).toString().padLeft(2, '0'),
                  style: TextStyle(
                    color:
                        isExpanded
                            ? const Color(0xFFFCABD1)
                            : const Color(0xff8A4A74),
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ],
          ),

          children: List.generate(widget.module.videos.length, (videoIndex) {
            final video = widget.module.videos[videoIndex];

            return Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: VideoItem(
                video: video,
                duration: widget.formatDuration(video.durationSeconds),

                isPreview: widget.moduleIndex == 0 && videoIndex == 0,

                showImage: widget.moduleIndex == 0 && videoIndex == 0,

                showCompleted: widget.moduleIndex == 0 && videoIndex == 0,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final VideoEntity video;
  final String duration;

  final bool isPreview;
  final bool showImage;
  final bool showCompleted;

  const VideoItem({
    super.key,
    required this.video,
    required this.duration,
    required this.isPreview,
    required this.showImage,
    required this.showCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Check أو Lock
        SizedBox(
          width: 28.w,
          child: Center(
            child: Icon(
              showCompleted
                  ? Icons.check_circle_outline_rounded
                  : Icons.lock_outline_rounded,
              color:
                  showCompleted
                      ? const Color(0xff32B56A)
                      : Colors.grey.shade500,
              size: 22.sp,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        /// Title + Duration
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D2D2D),
                ),
              ),

              SizedBox(height: 6.h),

              Row(
                children: [
                  if (isPreview)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff6ED39D),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "PREVIEW",
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  if (isPreview) SizedBox(width: 8.w),

                  Text(
                    duration,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        /// Thumbnail أو Lock Box
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child:
              showImage
                  ? Image.network(
                    "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=300",
                    width: 56.w,
                    height: 56.w,
                    fit: BoxFit.cover,
                  )
                  : Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF1F5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.grey.shade500,
                      size: 22.sp,
                    ),
                  ),
        ),
      ],
    );
  }
}
