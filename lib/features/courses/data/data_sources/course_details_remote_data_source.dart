import 'package:dio/dio.dart';

abstract class CourseDetailsRemoteDataSource {
  Future<Map<String, dynamic>> getCourseDetails(String courseId);
}

class CourseDetailsRemoteDataSourceImpl
    implements CourseDetailsRemoteDataSource {
  final Dio dio;
  CourseDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getCourseDetails(String courseId) async {
    final response = await dio.get(
      "/CourseAdminestrator/GetCourseDetalisPublicById/$courseId",
    );

    return response.data["data"];
  }
}
