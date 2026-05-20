import '../../../../core/network/dio_helper.dart';
import '../models/course_book_details_model.dart';

class CourseBookDetailsRemoteDS {
  Future<CourseBookDetailsModel> getDetails(String id) async {
    final response = await DioHelper.createDio().get(
      "CourseBookStudent/GetCourseBookDetailsToStudentEnrolled/$id",
    );

    return CourseBookDetailsModel.fromJson(response.data[0]);
  }
}
