import 'package:arabas_app/features/my_courses/domain/entity/my_course_details_entity.dart';

abstract class MyCourseDetailsState {}

class MyCourseDetailsInitial extends MyCourseDetailsState {}

class MyCourseDetailsLoading extends MyCourseDetailsState {}

class MyCourseDetailsSuccess extends MyCourseDetailsState {
  final MyCourseDetailsEntity course;

  MyCourseDetailsSuccess(this.course);
}

class MyCourseDetailsError extends MyCourseDetailsState {
  final String message;

  MyCourseDetailsError(this.message);
}
