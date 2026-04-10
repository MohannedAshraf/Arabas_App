import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio;

  AuthApiService(this.dio);

  Future<Response> register(Map<String, dynamic> body) async {
    return await dio.post(
      "https://arabas.runasp.net/api/Auth/register",
      data: body,
    );
  }
}
