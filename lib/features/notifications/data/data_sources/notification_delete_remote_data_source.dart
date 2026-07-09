import 'package:arabas_app/core/services/notification_api_service.dart';
import 'package:arabas_app/features/notifications/data/models/delete_notification_model.dart';

abstract class NotificationDeleteRemoteDataSource {
  Future<DeleteNotificationModel> deleteNotification(String id);
}

class NotificationDeleteRemoteDataSourceImpl
    implements NotificationDeleteRemoteDataSource {
  final NotificationApiService apiService;

  NotificationDeleteRemoteDataSourceImpl(this.apiService);

  @override
  Future<DeleteNotificationModel> deleteNotification(String id) async {
    final response = await apiService.deleteNotification(id);

    return DeleteNotificationModel.fromJson(response.data);
  }
}
