import 'package:arabas_app/core/network/dio_helper.dart';
import 'package:arabas_app/features/my_courses/data/models/progress_in_course_model.dart';

abstract class ProgressInCourseRemoteDataSource {
  Future<List<ProgressInCourseModel>> getProgressInCourse({
    required String courseId,
  });
}

class ProgressInCourseRemoteDataSourceImpl
    implements ProgressInCourseRemoteDataSource {
  @override
  Future<List<ProgressInCourseModel>> getProgressInCourse({
    required String courseId,
  }) async {
    final response = await DioHelper.createDio().get(
      "Progress/get-by-course",
      queryParameters: {"courseId": courseId},
    );

    final List data = response.data["data"];

    return data.map((e) => ProgressInCourseModel.fromJson(e)).toList();
  }
}
