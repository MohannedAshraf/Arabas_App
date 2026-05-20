import 'package:arabas_app/features/book_courses/domain/entity/course_book_details_entity.dart';

abstract class CourseBookDetailsRepo {
  Future<CourseBookDetailsEntity> getDetails(String id);
}
