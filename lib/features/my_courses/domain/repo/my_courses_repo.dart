// my_courses_repo.dart

import 'package:arabas_app/features/my_courses/domain/entity/my_courses_entity.dart';

abstract class MyCoursesRepo {
  Future<List<MyCourseEntity>> getMyCourses();
}
