import 'package:arabas_app/core/services/notification_api_service.dart';
import 'package:arabas_app/features/notifications/data/models/read_notification_model.dart';

abstract class NotificationReadRemoteDataSource {
  Future<ReadNotificationModel> readNotification(String id);
}

class NotificationReadRemoteDataSourceImpl
    implements NotificationReadRemoteDataSource {
  final NotificationApiService apiService;

  NotificationReadRemoteDataSourceImpl(this.apiService);

  @override
  Future<ReadNotificationModel> readNotification(String id) async {
    final response = await apiService.readNotification(id);

    return ReadNotificationModel.fromJson(response.data);
  }
}
