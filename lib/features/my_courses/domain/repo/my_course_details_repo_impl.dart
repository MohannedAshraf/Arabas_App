import 'package:arabas_app/features/my_courses/data/data_sources/my_course_details_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/domain/entity/my_course_details_entity.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_course_details_repo.dart';

class MyCourseDetailsRepoImpl implements MyCourseDetailsRepo {
  final MyCourseDetailsRemoteDataSource remoteDataSource;

  MyCourseDetailsRepoImpl(this.remoteDataSource);

  @override
  Future<MyCourseDetailsEntity> getCourseDetails(String courseId) async {
    return await remoteDataSource.getCourseDetails(courseId);
  }
}
