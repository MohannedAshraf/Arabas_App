import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  // ======================
  // Access Token
  // ======================
  String getAccessToken() => prefs.getString('access') ?? '';

  Future<void> saveAccessToken(String token) async {
    await prefs.setString('access', token);
  }

  // ======================
  // Refresh Token
  // ======================
  String getRefreshToken() => prefs.getString('refresh') ?? '';

  Future<void> saveRefreshToken(String token) async {
    await prefs.setString('refresh', token);
  }

  // ======================
  // Clear all
  // ======================
  Future<void> clear() async {
    await prefs.remove('access');
    await prefs.remove('refresh');
  }
}
