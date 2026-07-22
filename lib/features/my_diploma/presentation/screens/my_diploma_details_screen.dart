// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_details_entity.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_details_cubit.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_details_state.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_video_cubit.dart';
import 'package:arabas_app/features/my_diploma/presentation/screens/my_diploma_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDiplomaDetailsScreen extends StatefulWidget {
  final String diplomaId;

  const MyDiplomaDetailsScreen({super.key, required this.diplomaId});

  @override
  State<MyDiplomaDetailsScreen> createState() => _MyDiplomaDetailsScreenState();
}

class _MyDiplomaDetailsScreenState extends State<MyDiplomaDetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,

          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.black),
          title: Text(
            "تفاصيل الدبلومة",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),

        body: BlocBuilder<MyDiplomaDetailsCubit, MyDiplomaDetailsState>(
          builder: (context, state) {
            if (state is MyDiplomaDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MyDiplomaDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is MyDiplomaDetailsSuccess) {
              final diploma = state.diploma;

              return NestedScrollView(
                headerSliverBuilder: (context, innerScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.only(
                          right: 16.w,
                          left: 16.w,
                          top: 16.h,
                          bottom: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24.r),
                              child: Image.network(
                                diploma.diplomaImage,
                                height: 200.h,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            Text(
                              diploma.diplomaName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: AppColors.black,
                              ),
                            ),

                            SizedBox(height: 15.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${diploma.progressPercent.toInt()}%",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  "التقدم الكلي",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: SizedBox(
                                height: 15.h,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: LinearProgressIndicator(
                                    value: diploma.progressPercent / 100,
                                    backgroundColor: const Color(0xffDCEAFA),
                                    valueColor: const AlwaysStoppedAnimation(
                                      AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _TabBarDelegate(
                        TabBar(
                          dividerColor: Colors.transparent,
                          indicatorColor: AppColors.primary,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.black,
                          labelStyle: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: const [
                            Tab(text: "الوصف"),
                            Tab(text: "الموديولات"),
                          ],
                        ),
                      ),
                    ),
                  ];
                },

                body: TabBarView(
                  children: [
                    _DiplomaDescriptionTab(
                      description: diploma.description,
                      isExpanded: isExpanded,
                      onToggle: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),

                    ListView.builder(
                      padding: EdgeInsets.all(20.w),
                      itemCount: diploma.modules.length,
                      itemBuilder: (context, index) {
                        return _ModuleCard(module: diploma.modules[index]);
                      },
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

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) {
    return false;
  }
}

class _DiplomaDescriptionTab extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _DiplomaDescriptionTab({
    required this.description,
    required this.isExpanded,
    required this.onToggle,
  });

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
      padding: EdgeInsets.all(20.w),
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            right: 15.w,
            left: 15.w,
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
                "عن الدبلومة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),

              SizedBox(height: 16.h),

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

class _ModuleCard extends StatefulWidget {
  final MyDiplomaDetailsModuleEntity module;

  const _ModuleCard({required this.module});

  @override
  State<_ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<_ModuleCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final module = widget.module;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white, // يفضل أبيض حتى بعد الفتح
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      module.title,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// أيقونة الطبقات
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.layers_rounded,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  AnimatedRotation(
                    turns: expanded ? .5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary,
                      size: 28.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (expanded) ...[
            Divider(height: 1),

            SizedBox(height: 12.h),

            ListView.separated(
              itemCount: module.videos.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return _VideoTile(video: module.videos[index]);
              },
            ),

            SizedBox(height: 16.h),

            if (module.exams.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: module.exams.map((e) => ExamCard(exam: e)).toList(),
                ),
              ),

            SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }
}

class _VideoTile extends StatelessWidget {
  final MyDiplomaDetailsVideoEntity video;

  const _VideoTile({required this.video});

  @override
  Widget build(BuildContext context) {
    final completed = video.watchPercent >= 100;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xffF5F7FA),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create:
                            (_) =>
                                sl<MyDiplomaVideoCubit>()..getVideo(video.id),
                        child: MyDiplomaVideoScreen(videoId: video.id),
                      ),
                ),
              );
            },
            child: Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    completed
                        ? const Color(0xffDDF6E5)
                        : AppColors.primary.withOpacity(.12),
              ),
              child: Icon(
                completed ? Icons.check_rounded : Icons.play_arrow_rounded,
                color: completed ? Colors.green : AppColors.primary,
                size: 22.sp,
              ),
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  video.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),

                SizedBox(height: 10.h),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: LinearProgressIndicator(
                    value: video.watchPercent / 100,
                    minHeight: 5.h,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(
                      completed ? Colors.green : AppColors.primary,
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

String formatDuration(int seconds) {
  final duration = Duration(seconds: seconds);

  final minutes = duration.inMinutes;
  final remainingSeconds = duration.inSeconds % 60;

  return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
}

class ExamCard extends StatelessWidget {
  final MyDiplomaDetailsExamEntity exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff9B6787), AppColors.primary],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            exam.isFinal ? "${exam.title} (امتحان نهائي)" : exam.title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${exam.durationInMinutes} دقيقه",
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white70, fontSize: 18.sp),
              ),
              SizedBox(width: 6.w),
              Icon(Icons.timer_outlined, color: Colors.white70, size: 22.sp),
            ],
          ),
        ],
      ),
    );
  }
}
