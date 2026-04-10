import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceHelper {
  static final _storage = FlutterSecureStorage();
  static const _key = "device_id";

  /// يرجع Device ID ثابت (يتخزن مرة واحدة)
  static Future<String> getDeviceId() async {
    String? storedId = await _storage.read(key: _key);

    if (storedId != null) return storedId;

    String newId = const Uuid().v4();
    await _storage.write(key: _key, value: newId);

    return newId;
  }

  static Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      return "${android.manufacturer} ${android.model}";
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return ios.utsname.machine;
    }

    return "unknown device";
  }

  static String getPlatform() {
    if (Platform.isAndroid) return "Android";
    if (Platform.isIOS) return "iOS";
    return "Flutter";
  }
}
