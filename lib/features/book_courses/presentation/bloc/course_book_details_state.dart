import 'package:arabas_app/features/book_courses/domain/entity/course_book_details_entity.dart';

abstract class CourseBookDetailsState {}

class DetailsInitial extends CourseBookDetailsState {}

class DetailsLoading extends CourseBookDetailsState {}

class DetailsError extends CourseBookDetailsState {
  final String message;
  DetailsError(this.message);
}

class DetailsLoaded extends CourseBookDetailsState {
  final CourseBookDetailsEntity data;
  final int selectedVideoIndex;

  DetailsLoaded(this.data, this.selectedVideoIndex);
}
