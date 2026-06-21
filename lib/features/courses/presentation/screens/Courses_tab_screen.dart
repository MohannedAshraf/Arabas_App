// ignore_for_file: file_names, deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_in-section-cubit.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_section_state.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_sections_cubit.dart';
import 'package:arabas_app/features/courses/presentation/screens/courses_in_section_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesTabScreen extends StatefulWidget {
  const CoursesTabScreen({super.key});

  @override
  State<CoursesTabScreen> createState() => _CoursesTabScreenState();
}

class _CoursesTabScreenState extends State<CoursesTabScreen> {
  @override
  void initState() {
    context.read<CoursesCubit>().getSections();
    super.initState();
  }

  String removeHtmlTags(String htmlText) {
    return htmlText
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "الأقسام",
          style: TextStyle(color: AppColors.primary),
        ),
      ),

      body: Column(
        children: [
          // /// 🔍 Search Bar
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          //   child: TextField(
          //     readOnly: true,
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

          // SizedBox(height: 20.h),

          /// 📦 Sections List
          Expanded(
            child: BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state) {
                if (state is CoursesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CoursesError) {
                  return Center(child: Text(state.message));
                }

                if (state is CoursesSuccess) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: state.sections.length,
                    itemBuilder: (context, index) {
                      final section = state.sections[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider(
                                    create: (_) => sl<CoursesBySectionCubit>(),
                                    child: CoursesBySectionScreen(
                                      sectionId: section.id,
                                      sectionTitle: section.title,
                                    ),
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30.h),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(
                                  18.w,
                                  24.h,
                                  18.w,
                                  16.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffE7EBF0),
                                  borderRadius: BorderRadius.circular(26.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 10.h),

                                    /// Title
                                    Text(
                                      section.title,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                    SizedBox(height: 20.h),

                                    /// Description
                                    Text(
                                      removeHtmlTags(section.description),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black.withOpacity(.7),
                                        height: 1.5,
                                      ),
                                    ),

                                    SizedBox(height: 10.h),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          textDirection: TextDirection.rtl,
                                          "استعرض الكورسات",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              /// Image
                              Positioned(
                                left: 18.w,
                                top: -20.h,
                                child: Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    image: DecorationImage(
                                      image: NetworkImage(section.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
