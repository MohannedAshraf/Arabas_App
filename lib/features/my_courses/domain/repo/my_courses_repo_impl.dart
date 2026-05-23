// my_courses_repo_impl.dart

import 'package:arabas_app/features/my_courses/data/data_sources/my_courses_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/domain/entity/my_courses_entity.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_courses_repo.dart';

class MyCoursesRepoImpl implements MyCoursesRepo {
  final MyCoursesRemoteDataSource remoteDataSource;

  MyCoursesRepoImpl(this.remoteDataSource);

  @override
  Future<List<MyCourseEntity>> getMyCourses() async {
    return await remoteDataSource.getMyCourses();
  }
}
