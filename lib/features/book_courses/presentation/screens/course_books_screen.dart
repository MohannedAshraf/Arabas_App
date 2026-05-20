// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course-book_cubit.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course_book_details_cubit.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course_book_state.dart';
import 'package:arabas_app/features/book_courses/presentation/screens/course_book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:html/parser.dart' as html_parser;

class CourseBooksScreen extends StatelessWidget {
  const CourseBooksScreen({super.key});
  String htmlToPlainText(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text.trim() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourseBooksCubit(sl())..getCourseBooks(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: AppColors.primary),
          title: const Text(
            "كورسات الكتاب",
            style: TextStyle(color: AppColors.primary),
          ),
        ),
        body: BlocBuilder<CourseBooksCubit, CourseBooksState>(
          builder: (context, state) {
            if (state is CourseBooksLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CourseBooksError) {
              return Center(child: Text(state.message));
            }

            if (state is CourseBooksLoaded) {
              if (state.books.isEmpty) {
                return const Center(
                  child: Text(
                    "لا يوجد كورسات كتاب مشترك بها حالياً",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider(
                                create:
                                    (_) =>
                                        sl<CourseBookDetailsCubit>()
                                          ..getDetails(book.id),
                                child: CourseBookDetailsScreen(
                                  courseId: book.id,
                                ),
                              ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // icon
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight.withOpacity(
                                      .2,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.menu_book_rounded,
                                    color: AppColors.primary,
                                    size: 50,
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // title + description
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        book.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        textDirection: TextDirection.rtl,
                                        htmlToPlainText(book.description),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColors.textGray,
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // التاريخ تحت خالص
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: AppColors.textGray,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  book.createdAt.split("T").first,
                                  style: const TextStyle(
                                    color: AppColors.textGray,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
    );
  }
}
