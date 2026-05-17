import 'package:arabas_app/features/courses/domain/entities/courses_section_entity.dart';

abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesSuccess extends CoursesState {
  final List<SectionEntity> sections;
  CoursesSuccess(this.sections);
}

class CoursesError extends CoursesState {
  final String message;
  CoursesError(this.message);
}
