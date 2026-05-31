import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/services/auth_refresh_services.dart';
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

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final storage = sl<LocalStorageService>();
          final token = storage.getAccessToken();

          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            print("401 DETECTED");
            print("REQUEST PATH: ${error.requestOptions.path}");
            final path = error.requestOptions.path;

            /// منع الـ Refresh Loop
            if (path.contains("Auth/login") ||
                path.contains("Auth/register") ||
                path.contains("Auth/refresh-token")) {
              return handler.next(error);
            }

            try {
              print("401 DETECTED");
              print("TRYING REFRESH TOKEN...");

              await sl<AuthRefreshService>().refreshToken();

              final newToken = sl<LocalStorageService>().getAccessToken();

              print("NEW TOKEN RECEIVED");

              error.requestOptions.headers["Authorization"] =
                  "Bearer $newToken";

              final response = await dio.fetch(error.requestOptions);

              return handler.resolve(response);
            } catch (e) {
              print("REFRESH FAILED");
              print(e);

              await sl<LocalStorageService>().clear();

              return handler.reject(error);
            }
          }

          return handler.next(error);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
