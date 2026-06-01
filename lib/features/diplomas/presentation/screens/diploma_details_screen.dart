// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_state.dart';
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

class _DiplomaDetailsScreenState extends State<DiplomaDetailsScreen> {
  bool isExpanded = false;

  String cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String formatDuration(int seconds) {
    final minutes = (seconds / 60).round();
    return "دقيقة $minutes ";
  }

  /// 🔥 NEW: short text helper
  String _getShortText(String html) {
    final plainText = html.replaceAll(RegExp(r'<[^>]*>'), '');

    if (plainText.length <= 120) return html;

    final short = plainText.substring(0, 120);

    return "$short...";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

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
            cleanHtml(diploma.description);

            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 15.h),

              child: Column(
                children: [
                  /// IMAGE
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Image.network(
                      diploma.imageUrl,
                      width: double.infinity,
                      height: 260.h,
                      fit: BoxFit.fill,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),

                    child: Column(
                      children: [
                        /// TITLE
                        Text(
                          diploma.title,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: 15.h),

                        /// PRICE + HOURS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${diploma.price} جنيه",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.schedule,
                              color: AppColors.primary,
                              size: 18.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "${diploma.durationHours} ساعة",
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        /// TITLE
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
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

                        SizedBox(height: 8.h),

                        /// ✅ FIXED HTML DESCRIPTION
                        Html(
                          data:
                              isExpanded
                                  ? '''
<div dir="rtl" style="text-align:right;">
${diploma.description}
</div>
'''
                                  : '''
<div dir="rtl" style="text-align:right;">
${_getShortText(diploma.description)}
</div>
''',
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

                        SizedBox(height: 5.h),

                        /// TOGGLE BUTTON
                        InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              isExpanded ? "عرض أقل" : "عرض المزيد",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 18.h),

                        /// VIDEOS TITLE
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "الفيديوهات",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 15.h),

                        ...diploma.modules
                            .expand((module) => module.videos)
                            .map(
                              (video) => Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 55.w,
                                      height: 55.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(
                                          .1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.play_circle_fill,
                                        color: AppColors.primary,
                                        size: 36.sp,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            video.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            formatDuration(
                                              video.durationSeconds,
                                            ),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.textGray,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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

          return const SizedBox();
        },
      ),
    );
  }
}
