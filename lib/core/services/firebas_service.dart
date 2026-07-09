import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final LocalStorageService localStorage;

  FirebaseService(this.localStorage);

  Future<void> init() async {
    // Request Notification Permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint("Notification Permission: ${settings.authorizationStatus}");

    // Get FCM Token
    final token = await _firebaseMessaging.getToken();

    if (token != null && token.isNotEmpty) {
      await localStorage.saveFcmToken(token);

      debugPrint("====================================");
      debugPrint("FCM TOKEN : $token");
      debugPrint("====================================");
    }

    // Listen For Token Refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      await localStorage.saveFcmToken(newToken);

      debugPrint("====================================");
      debugPrint("NEW FCM TOKEN : $newToken");
      debugPrint("====================================");
    });
  }

  Future<String> getToken() async {
    return localStorage.getFcmToken();
  }
}
