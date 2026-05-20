import 'package:dio/dio.dart';

abstract class VerifyBookRemoteDataSource {
  Future<bool> verifyBook(String code);
}

class VerifyBookRemoteDataSourceImpl implements VerifyBookRemoteDataSource {
  final Dio dio;

  VerifyBookRemoteDataSourceImpl(this.dio);

  @override
  Future<bool> verifyBook(String code) async {
    try {
      final response = await dio.post(
        'CourseBookAdmin/EnrollStudentToCourseBook/$code',
      );

      return response.data['data'] ?? false;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'حدث خطأ أثناء تفعيل الكتاب',
      );
    }
  }
}
