// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/features/courses/presentation/bloc/course_details_cubit.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_in-section-cubit.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_in_section_state.dart';
import 'package:arabas_app/features/courses/presentation/screens/course_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class CoursesBySectionScreen extends StatefulWidget {
  final String sectionId;
  final String sectionTitle;

  const CoursesBySectionScreen({
    super.key,
    required this.sectionId,
    required this.sectionTitle,
  });

  @override
  State<CoursesBySectionScreen> createState() => _CoursesBySectionScreenState();
}

class _CoursesBySectionScreenState extends State<CoursesBySectionScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    context.read<CoursesBySectionCubit>().getCourses(widget.sectionId);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<CoursesBySectionCubit>().loadMore(widget.sectionId);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.sectionTitle,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackButton(color: AppColors.primary),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          //   child: TextField(
          //     readOnly: true, // مش شغال حالياً
          //     decoration: InputDecoration(
          //       hintText: "ابحث عن قسم...",
          //       prefixIcon: const Icon(Icons.search, color: AppColors.primary),

          //       filled: true,
          //       fillColor: Colors.white,

          //       contentPadding: const EdgeInsets.symmetric(vertical: 14),

          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(30),
          //         borderSide: BorderSide.none,
          //       ),

          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(30),
          //         borderSide: const BorderSide(color: Colors.black12),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<CoursesBySectionCubit, CoursesBySectionState>(
              builder: (context, state) {
                if (state is CoursesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CoursesSuccess) {
                  return ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    itemCount: state.courses.length,

                    itemBuilder: (_, i) {
                      final course = state.courses[i];

                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// IMAGE + OFFER
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                  child: Image.network(
                                    course.imageUrl,
                                    width: double.infinity,
                                    height: 300.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),

                                if (course.offer > 0)
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Text(
                                        "%${course.offer} خصم",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  /// TITLE
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      course.title,
                                      textDirection: TextDirection.ltr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  /// DURATION
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${course.durationHours} ساعة",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),

                                        Icon(
                                          Icons.access_time,
                                          color: AppColors.primary,
                                          size: 20.sp,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10.h),

                                  /// PRICE
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${course.priceInEGP} ج.م",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        Icon(
                                          Icons.payments,
                                          color: AppColors.primary,
                                          size: 20.sp,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 15.h),

                                  /// BUTTON
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14.r,
                                          ),
                                        ),
                                      ),

                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => BlocProvider(
                                                  create:
                                                      (_) =>
                                                          sl<
                                                              CourseDetailsCubit
                                                            >()
                                                            ..getCourseDetails(
                                                              course.id,
                                                            ),
                                                  child: CourseDetailsScreen(
                                                    courseId: course.id,
                                                  ),
                                                ),
                                          ),
                                        );
                                      },

                                      child: Text(
                                        "عرض التفاصيل",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
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
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
