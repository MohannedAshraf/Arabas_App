import 'package:arabas_app/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<NotificationPageEntity> getNotifications(int pageNumber);
}
