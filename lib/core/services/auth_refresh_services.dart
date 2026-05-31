import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:dio/dio.dart';

class AuthRefreshService {
  final LocalStorageService storage;

  AuthRefreshService(this.storage);

  Future<void> refreshToken() async {
    final refreshToken = storage.getRefreshToken();
    final deviceId = storage.getDeviceId();
    final platform = storage.getPlatform();
    final fingerprint = storage.getFingerprint();

    print("Refresh Token: $refreshToken");
    print("Device Id: $deviceId");
    print("Platform: $platform");
    print("Fingerprint: $fingerprint");

    if (refreshToken.isEmpty) {
      throw Exception("Refresh token not found");
    }

    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: "https://arabas.runasp.net/api/",
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      final response = await dio.post(
        "Auth/refresh-token",
        data: {
          "refreshToken": refreshToken,
          "deviceId": deviceId,
          "platform": platform,
          "fingerPrint": fingerprint,
        },
      );

      final data = response.data["data"];

      if (data == null) {
        print("DATA IS NULL");
        throw Exception("Refresh response data is null");
      }

      await storage.saveAccessToken(data["accessToken"]);

      await storage.saveRefreshToken(data["refreshToken"]);
    } on DioException {
      rethrow;
    }
  }
}
