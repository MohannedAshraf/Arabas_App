import 'package:arabas_app/features/my_courses/domain/entity/progress_in_course_entity.dart';

abstract class ProgressInCourseState {}

class ProgressInCourseInitial extends ProgressInCourseState {}

class ProgressInCourseLoading extends ProgressInCourseState {}

class ProgressInCourseSuccess extends ProgressInCourseState {
  final List<ProgressInCourseEntity> progress;

  ProgressInCourseSuccess(this.progress);
}

class ProgressInCourseFailure extends ProgressInCourseState {
  final String message;

  ProgressInCourseFailure(this.message);
}
