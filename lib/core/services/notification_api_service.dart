import 'package:dio/dio.dart';

class NotificationApiService {
  final Dio dio;

  NotificationApiService(this.dio);

  Future<Response> getUnreadCount() async {
    return await dio.get("Notifications/unread-count");
  }

  Future<Response> getNotifications({required int pageNumber}) async {
    return await dio.get(
      "Notifications/get-my-notifications",
      queryParameters: {"pageNumber": pageNumber},
    );
  }

  Future<Response> readNotification(String id) async {
    return await dio.put("Notifications/$id/read");
  }

  Future<Response> deleteNotification(String id) async {
    return await dio.delete("Notifications/$id");
  }

  Future<Response> getActiveAnnouncements() async {
    return await dio.get("Announcement/Active");
  }
}
