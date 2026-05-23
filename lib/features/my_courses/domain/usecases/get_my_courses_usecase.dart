// get_my_courses_usecase.dart

import 'package:arabas_app/features/my_courses/domain/entity/my_courses_entity.dart';

import '../repo/my_courses_repo.dart';

class GetMyCoursesUseCase {
  final MyCoursesRepo repo;

  GetMyCoursesUseCase(this.repo);

  Future<List<MyCourseEntity>> call() async {
    return await repo.getMyCourses();
  }
}
