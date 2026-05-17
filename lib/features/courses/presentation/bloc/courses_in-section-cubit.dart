// ignore_for_file: file_names

import 'package:arabas_app/features/courses/domain/entities/courses_in_section_entity.dart';
import 'package:arabas_app/features/courses/domain/usecases/get_courses_in_section_usecase.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_in_section_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesBySectionCubit extends Cubit<CoursesBySectionState> {
  final GetCoursesUseCase useCase;
  CoursesBySectionCubit(this.useCase) : super(CoursesInitial());

  int page = 1;
  bool hasMore = true;
  List<CoursesInSectionEntity> courses = [];

  Future<void> getCourses(String sectionId) async {
    emit(CoursesLoading());

    page = 1;
    courses.clear();

    final result = await useCase(sectionId, page);
    courses.addAll(result);

    hasMore = result.length == 6;
    emit(CoursesSuccess(courses, hasMore));
  }

  Future<void> loadMore(String sectionId) async {
    if (!hasMore) return;

    page++;
    emit(CoursesPaginationLoading());

    final result = await useCase(sectionId, page);
    courses.addAll(result);

    hasMore = result.length == 6;
    emit(CoursesSuccess(courses, hasMore));
  }
}
