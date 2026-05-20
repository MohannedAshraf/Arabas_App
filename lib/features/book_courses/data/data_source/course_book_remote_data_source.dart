import 'package:dio/dio.dart';
import '../../../../core/services/local_storage_services.dart';
import '../models/course_book_model.dart';

abstract class CourseBooksRemoteDataSource {
  Future<List<CourseBookModel>> getEnrolledCourseBooks();
}

class CourseBooksRemoteDataSourceImpl implements CourseBooksRemoteDataSource {
  final Dio dio;
  final LocalStorageService localStorage;

  CourseBooksRemoteDataSourceImpl(this.dio, this.localStorage);

  @override
  Future<List<CourseBookModel>> getEnrolledCourseBooks() async {
    final token = localStorage.getAccessToken();

    final response = await dio.get(
      "CourseBookStudent/GetAllCourseBooksToStudentEnrolled",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    final List data = response.data;

    return data.map((e) => CourseBookModel.fromJson(e)).toList();
  }
}
