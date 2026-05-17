import 'package:dio/dio.dart';

abstract class CoursesInSectionRemoteDataSource {
  Future<Map<String, dynamic>> getCoursesBySection({
    required String sectionId,
    required int page,
  });
}

class CoursesInSectionRemoteDataSourceImpl
    implements CoursesInSectionRemoteDataSource {
  final Dio dio;
  CoursesInSectionRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getCoursesBySection({
    required String sectionId,
    required int page,
  }) async {
    final response = await dio.get(
      "CourseAdminestrator/GetAllCoursesBySectionId/$sectionId",
      queryParameters: {"pageNumber": page, "pageSize": 6},
    );

    return response.data;
  }
}
