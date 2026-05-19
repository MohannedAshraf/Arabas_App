import 'package:arabas_app/features/courses/data/data_sources/course_details_remote_data_source.dart';
import 'package:arabas_app/features/courses/data/models/course_details_model.dart';
import 'package:arabas_app/features/courses/domain/repo/course_details_repo.dart';

import '../../domain/entities/course_details_entity.dart';

class CourseDetailsRepositoryImpl implements CourseDetailsRepository {
  final CourseDetailsRemoteDataSource remote;
  CourseDetailsRepositoryImpl(this.remote);

  @override
  Future<CourseDetailsEntity> getCourseDetails(String id) async {
    final response = await remote.getCourseDetails(id);
    return CourseDetailsModel.fromJson(response);
  }
}
