import 'package:arabas_app/features/notifications/domain/entities/delete_notification_entity.dart';

abstract class NotificationDeleteRepository {
  Future<DeleteNotificationEntity> deleteNotification(String id);
}
