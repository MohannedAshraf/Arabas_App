// my_courses_state.dart

import 'package:arabas_app/features/my_courses/domain/entity/my_courses_entity.dart';

abstract class MyCoursesState {}

class MyCoursesInitial extends MyCoursesState {}

class MyCoursesLoading extends MyCoursesState {}

class MyCoursesLoaded extends MyCoursesState {
  final List<MyCourseEntity> courses;

  MyCoursesLoaded(this.courses);
}

class MyCoursesError extends MyCoursesState {
  final String message;

  MyCoursesError(this.message);
}
