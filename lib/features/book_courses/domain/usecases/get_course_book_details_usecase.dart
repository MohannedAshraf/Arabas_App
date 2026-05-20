import 'package:arabas_app/features/book_courses/domain/entity/course_book_details_entity.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_details_repo.dart';

class GetCourseBookDetailsUseCase {
  final CourseBookDetailsRepo repo;

  GetCourseBookDetailsUseCase(this.repo);

  Future<CourseBookDetailsEntity> call(String id) {
    return repo.getDetails(id);
  }
}
