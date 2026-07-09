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
  // Device Id
  // ======================
  Future<void> saveDeviceId(String value) async {
    await prefs.setString('deviceId', value);
  }

  String getDeviceId() {
    return prefs.getString('deviceId') ?? '';
  }

  // ======================
  // Platform
  // ======================
  Future<void> savePlatform(String value) async {
    await prefs.setString('platform', value);
  }

  String getPlatform() {
    return prefs.getString('platform') ?? '';
  }

  // ======================
  // Fingerprint
  // ======================
  Future<void> saveFingerprint(String value) async {
    await prefs.setString('fingerprint', value);
  }

  String getFingerprint() {
    return prefs.getString('fingerprint') ?? '';
  }

  // ======================
  // FCM Token
  // ======================
  Future<void> saveFcmToken(String value) async {
    await prefs.setString('fcmToken', value);
  }

  String getFcmToken() {
    return prefs.getString('fcmToken') ?? '';
  }

  // ======================
  // Clear all
  // ======================
  Future<void> clear() async {
    await prefs.remove('access');
    await prefs.remove('refresh');
    await prefs.remove('deviceId');
    await prefs.remove('platform');
    await prefs.remove('fingerprint');
    await prefs.remove('fcmToken');
  }
}
