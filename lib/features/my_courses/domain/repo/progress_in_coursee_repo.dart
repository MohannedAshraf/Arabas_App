import 'package:arabas_app/features/my_courses/domain/entity/progress_in_course_entity.dart';

abstract class ProgressInCourseRepository {
  Future<List<ProgressInCourseEntity>> getProgressInCourse({
    required String courseId,
  });
}
