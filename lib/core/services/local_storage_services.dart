import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  String getToken() {
    return prefs.getString('token') ?? '';
  }

  Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  Future<void> clearToken() async {
    await prefs.remove('token');
  }
}
