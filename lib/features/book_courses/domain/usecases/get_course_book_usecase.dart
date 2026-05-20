import 'package:arabas_app/features/book_courses/domain/entity/course_book_entity.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_repo.dart';

class GetCourseBooksUseCase {
  final CourseBooksRepo repo;

  GetCourseBooksUseCase(this.repo);

  Future<List<CourseBookEntity>> call() {
    return repo.getEnrolledCourseBooks();
  }
}
