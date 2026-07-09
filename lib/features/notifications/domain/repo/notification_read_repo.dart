import 'package:arabas_app/features/notifications/domain/entities/read_notification_entity.dart';

abstract class NotificationReadRepository {
  Future<ReadNotificationEntity> readNotification(String id);
}
