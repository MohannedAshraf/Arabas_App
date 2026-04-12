import 'package:dio/dio.dart';
import '../services/local_storage_services.dart';

class AuthRefreshService {
  final Dio dio;
  final LocalStorageService storage;

  AuthRefreshService(this.dio, this.storage);

  Future<void> refreshToken({
    required String deviceId,
    required String platform,
  }) async {
    try {
      final refreshToken = storage.getRefreshToken();

      final response = await dio.post(
        "https://arabas.runasp.net/api/Auth/refresh-token",
        data: {
          "refreshToken": refreshToken,
          "deviceId": deviceId,
          "platform": platform,
          "fingerPrint": "",
        },
      );

      final data = response.data['data'];

      // 🔥 update tokens
      await storage.saveAccessToken(data['accessToken']);
      await storage.saveRefreshToken(data['refreshToken']);
    } catch (e) {
      throw Exception("Refresh Token Failed: $e");
    }
  }
}
