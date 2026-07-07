import 'package:arabas_app/features/my_courses/data/data_sources/progress_in_course_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/domain/entity/progress_in_course_entity.dart';
import 'package:arabas_app/features/my_courses/domain/repo/progress_in_coursee_repo.dart';

class ProgressInCourseRepositoryImpl implements ProgressInCourseRepository {
  final ProgressInCourseRemoteDataSource remoteDataSource;

  ProgressInCourseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProgressInCourseEntity>> getProgressInCourse({
    required String courseId,
  }) async {
    return await remoteDataSource.getProgressInCourse(courseId: courseId);
  }
}
