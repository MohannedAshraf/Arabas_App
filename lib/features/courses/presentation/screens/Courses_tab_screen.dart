// ignore_for_file: file_names

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_in-section-cubit.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_section_state.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_sections_cubit.dart';
import 'package:arabas_app/features/courses/presentation/screens/courses_in_section_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "الأقسام",
          style: TextStyle(color: AppColors.primary),
        ),
      ),
      body: Column(
        children: [
          /// 🔍 Search Bar (placeholder)
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
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.sections.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: .8,
                        ),
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
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(18),
                                  ),
                                  child: Image.network(
                                    section.imageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  10,
                                  10,
                                  10,
                                  6,
                                ),
                                child: Text(
                                  section.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              /// 📝 Description
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Html(
                                  data: section.description,
                                  style: {
                                    "body": Style(
                                      margin: Margins.zero,
                                      padding: HtmlPaddings.zero,
                                      fontSize: FontSize(12),
                                      maxLines: 2,
                                      textOverflow: TextOverflow.ellipsis,
                                      color: AppColors.textGray,
                                      textAlign: TextAlign.center,
                                    ),
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
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
