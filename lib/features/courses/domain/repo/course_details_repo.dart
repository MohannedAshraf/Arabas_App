import '../entities/course_details_entity.dart';

abstract class CourseDetailsRepository {
  Future<CourseDetailsEntity> getCourseDetails(String id);
}
