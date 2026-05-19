import 'package:arabas_app/features/courses/domain/entities/course_details_entity.dart';

abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsSuccess extends CourseDetailsState {
  final CourseDetailsEntity course;
  CourseDetailsSuccess(this.course);
}

class CourseDetailsError extends CourseDetailsState {
  final String message;
  CourseDetailsError(this.message);
}
