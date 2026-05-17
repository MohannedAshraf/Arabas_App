import 'package:dio/dio.dart';

abstract class CoursesRemoteDataSource {
  Future<List<Map<String, dynamic>>> getSections();
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final Dio dio;

  CoursesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Map<String, dynamic>>> getSections() async {
    final response = await dio.get("CourseAdminestrator/GetAllSections");

    return List<Map<String, dynamic>>.from(response.data['data']);
  }
}
