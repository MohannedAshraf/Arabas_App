import 'package:arabas_app/features/my_courses/data/models/my_course_details_model.dart';
import 'package:dio/dio.dart';

abstract class MyCourseDetailsRemoteDataSource {
  Future<MyCourseDetailsModel> getCourseDetails(String courseId);
}

class MyCourseDetailsRemoteDataSourceImpl
    implements MyCourseDetailsRemoteDataSource {
  final Dio dio;

  MyCourseDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<MyCourseDetailsModel> getCourseDetails(String courseId) async {
    final response = await dio.get(
      "Student/Course/course-details-subscribed/$courseId",
    );

    return MyCourseDetailsModel.fromJson(response.data["data"]);
  }
}
