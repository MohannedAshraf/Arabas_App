import 'package:dio/dio.dart';

class DioHelper {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://arabas.runasp.net/api/",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    // Logs أثناء التطوير
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
