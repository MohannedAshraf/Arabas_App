import 'package:arabas_app/features/my_courses/domain/entity/progress_in_course_entity.dart';
import 'package:arabas_app/features/my_courses/domain/repo/progress_in_coursee_repo.dart';

class ProgressInCourseUseCase {
  final ProgressInCourseRepository repository;

  ProgressInCourseUseCase(this.repository);

  Future<List<ProgressInCourseEntity>> call({required String courseId}) async {
    return await repository.getProgressInCourse(courseId: courseId);
  }
}
