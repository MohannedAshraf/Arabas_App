import 'package:arabas_app/features/courses/domain/repo/course_details_repo.dart';

import '../entities/course_details_entity.dart';

class GetCourseDetailsUseCase {
  final CourseDetailsRepository repo;
  GetCourseDetailsUseCase(this.repo);

  Future<CourseDetailsEntity> call(String id) {
    return repo.getCourseDetails(id);
  }
}
