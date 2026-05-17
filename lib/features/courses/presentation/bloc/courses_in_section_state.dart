import 'package:arabas_app/features/courses/domain/entities/courses_in_section_entity.dart';

abstract class CoursesBySectionState {}

class CoursesInitial extends CoursesBySectionState {}

class CoursesLoading extends CoursesBySectionState {}

class CoursesPaginationLoading extends CoursesBySectionState {}

class CoursesSuccess extends CoursesBySectionState {
  final List<CoursesInSectionEntity> courses;
  final bool hasMore;

  CoursesSuccess(this.courses, this.hasMore);
}

class CoursesError extends CoursesBySectionState {
  final String message;
  CoursesError(this.message);
}
