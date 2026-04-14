import 'package:arabas_app/features/auth/data/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
        debugPrint("ERROR : ${result.message}");
        throw Exception(result.message);
      }

      return result;
    } on DioException catch (e) {
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["Message"] ??
          "حدث خطأ في الاتصال بالسيرفر";

      debugPrint("ERROR : $message");
      debugPrint("STATUS CODE : ${e.response?.statusCode}");
      debugPrint("RESPONSE DATA : ${e.response?.data}");
      debugPrint("DIO ERROR TYPE : ${e.type}");

      throw Exception(message);
    } catch (e) {
      /// أي error تاني غير Dio
      debugPrint("ERROR : $e");
      throw Exception(e.toString());
    }
  }
}
