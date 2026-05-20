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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: TextField(
              readOnly: true, // مش شغال حالياً
              decoration: InputDecoration(
                hintText: "ابحث عن قسم...",
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(vertical: 14),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<CoursesBySectionCubit, CoursesBySectionState>(
              builder: (context, state) {
                if (state is CoursesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CoursesSuccess) {
                  return GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.courses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: .75,
                        ),
                    itemBuilder: (_, i) {
                      final course = state.courses[i];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider(
                                    create:
                                        (_) =>
                                            sl<CourseDetailsCubit>()
                                              ..getCourseDetails(course.id),
                                    child: CourseDetailsScreen(
                                      courseId: course.id,
                                    ),
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(18),
                                  ),
                                  child: Positioned.fill(
                                    child: Image.network(
                                      course.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  top: 6.h,
                                  left: 6.w,
                                  right: 6.w,
                                  bottom: 6.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    /// الاسم + السعر
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        /// اسم الكورس
                                        Text(
                                          course.title,
                                          textAlign: TextAlign.right,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp,
                                          ),
                                        ),

                                        SizedBox(height: 8.sp),

                                        /// السعر
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 18.sp,
                                              color: Colors.grey,
                                            ),

                                            SizedBox(width: 4.sp),

                                            Text(
                                              "${course.duration} ساعة",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Spacer(),

                                            Text(
                                              "${course.price} ج.م",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 4.sp),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: List.generate(
                                            5,
                                            (index) => Padding(
                                              padding: EdgeInsets.only(
                                                right: 2.w,
                                              ),
                                              child: Icon(
                                                index < course.rate.toInt()
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                                size: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.sp),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
