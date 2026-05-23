import 'package:arabas_app/features/my_courses/domain/entity/my_course_details_entity.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_course_details_repo.dart';

class GetMyCourseDetailsUsecase {
  final MyCourseDetailsRepo repo;

  GetMyCourseDetailsUsecase(this.repo);

  Future<MyCourseDetailsEntity> call(String courseId) async {
    return await repo.getCourseDetails(courseId);
  }
}
