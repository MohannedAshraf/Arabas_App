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
    final duration = Duration(seconds: seconds);

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
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

                        /// MODULES TITLE
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "محتوى الدبلومة",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 15.h),

                        ...diploma.modules.asMap().entries.map((entry) {
                          final index = entry.key;
                          final module = entry.value;

                          return Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                iconColor: AppColors.primary,
                                collapsedIconColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  side: BorderSide.none,
                                ),
                                collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  side: BorderSide.none,
                                ),

                                tilePadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),

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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),

                                subtitle: Text(
                                  textDirection: TextDirection.rtl,
                                  "${module.videos.length} محاضرة",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),

                                children:
                                    module.videos.map((video) {
                                      return ListTile(
                                        leading: Icon(
                                          Icons.play_circle_fill,
                                          color: AppColors.primary,
                                        ),
                                        title: Text(
                                          video.title,
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                        trailing: Text(
                                          formatDuration(video.durationSeconds),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColors.textGray,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          );
                        }),
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
