import 'package:arabas_app/features/my_courses/data/models/my_courses_model.dart';
import 'package:dio/dio.dart';

abstract class MyCoursesRemoteDataSource {
  Future<List<MyCourseModel>> getMyCourses();
}

class MyCoursesRemoteDataSourceImpl implements MyCoursesRemoteDataSource {
  final Dio dio;

  MyCoursesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MyCourseModel>> getMyCourses() async {
    final response = await dio.get("Student/Course/courses-subscribed");

    print(response.realUri);

    final List data = response.data["data"]["data"];

    return data.map((e) => MyCourseModel.fromJson(e)).toList();
  }
}
