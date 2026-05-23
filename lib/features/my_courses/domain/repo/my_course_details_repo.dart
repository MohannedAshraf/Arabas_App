import 'package:arabas_app/features/my_courses/domain/entity/my_course_details_entity.dart';

abstract class MyCourseDetailsRepo {
  Future<MyCourseDetailsEntity> getCourseDetails(String courseId);
}
