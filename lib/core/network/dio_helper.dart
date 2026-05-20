import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/services/local_storage_services.dart';
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

    /// 🔥 هنا بنجيب التوكن من SharedPreferences
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final storage = sl<LocalStorageService>();
          final token = storage.getAccessToken();

          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        /// 🔥 معالجة أخطاء التوكن
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: "غير مصرح لك، يرجى تسجيل الدخول مرة أخرى",
              ),
            );
          }

          return handler.next(error);
        },
      ),
    );

    // Logs أثناء التطوير
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
