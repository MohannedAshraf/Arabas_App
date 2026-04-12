import 'package:arabas_app/features/auth/data/models/login_model.dart';
import 'package:dio/dio.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await dio.post(
        "https://arabas.runasp.net/api/Auth/login",
        data: request.toJson(),
      );

      final result = LoginResponseModel.fromJson(response.data);

      if (!result.isSuccess) {
        throw Exception(result.message);
      }

      return result;
    } on DioException catch (e) {
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["Message"] ??
          "حدث خطأ في الاتصال بالسيرفر";

      throw Exception(message);
    }
  }
}
