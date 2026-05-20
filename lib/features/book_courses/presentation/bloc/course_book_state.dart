import 'package:arabas_app/features/book_courses/domain/entity/course_book_entity.dart';

abstract class CourseBooksState {}

class CourseBooksInitial extends CourseBooksState {}

class CourseBooksLoading extends CourseBooksState {}

class CourseBooksLoaded extends CourseBooksState {
  final List<CourseBookEntity> books;
  CourseBooksLoaded(this.books);
}

class CourseBooksError extends CourseBooksState {
  final String message;
  CourseBooksError(this.message);
}
