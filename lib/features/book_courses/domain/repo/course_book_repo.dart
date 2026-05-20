import 'package:arabas_app/features/book_courses/domain/entity/course_book_entity.dart';

abstract class CourseBooksRepo {
  Future<List<CourseBookEntity>> getEnrolledCourseBooks();
}
