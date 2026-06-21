// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/diplomas/domain/entities/diploma_details_entity.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                        price: diploma.price,
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
                return BottomPriceBar(price: state.diploma.price);
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
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 15.h),

              Row(
                children: [
                  Icon(Icons.schedule, color: AppColors.primary, size: 18.sp),

                  SizedBox(width: 5.w),

                  Text(
                    "$durationHours ساعة",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 13.sp),
                  ),

                  const Spacer(),

                  Text(
                    "$price جنيه",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TabBar(
                    controller: controller,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,

                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: "الوصف"),
                      Tab(text: "المحتوى"),
                      Tab(text: "الشهادات"),
                    ],
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

    if (plainText.length <= 120) return html;

    return "${plainText.substring(0, 120)}...";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (studentsInTrainingImages.isNotEmpty) ...[
            CarouselSlider.builder(
              itemCount: studentsInTrainingImages.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    studentsInTrainingImages[index].url,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: Icon(Icons.broken_image)),
                      );
                    },
                  ),
                );
              },
              options: CarouselOptions(
                height: 220.h,
                viewportFraction: 0.9,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                enlargeCenterPage: true,
              ),
            ),

            SizedBox(height: 16.h),
          ],
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "الوصف",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
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
    return ListView.builder(
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final module = modules[index];

        return Container(
          margin: EdgeInsets.only(bottom: 12.h),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade200),
          ),

          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

            child: ExpansionTile(
              iconColor: AppColors.primary,
              collapsedIconColor: AppColors.primary,

              leading: Container(
                width: 35.w,
                height: 35.h,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),

                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              title: Text(
                module.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),

              subtitle: Text(
                "${module.videos.length} محاضرة",
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),

              children:
                  module.videos.map((video) {
                    return ListTile(
                      leading: const Icon(
                        Icons.play_circle_fill,
                        color: AppColors.primary,
                      ),

                      title: Text(video.title),

                      trailing: Text(formatDuration(video.durationSeconds)),
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
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
                          color: Color(0xff5F2444),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            "المستوي الأساسي",
                            style: TextStyle(
                              color: Colors.white,
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
                          color: Color(0xff146A59),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Text(
                            "اعتماد دولي",
                            style: TextStyle(
                              color: AppColors.white,
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
              height: 280.h,
              child: CarouselSlider.builder(
                itemCount: certificates.length,
                itemBuilder: (context, index, realIndex) {
                  final certificate = certificates[index];

                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Image.network(
                      certificate.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 300.h,
                  viewportFraction: 0.95,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
