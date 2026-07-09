import 'package:arabas_app/features/notifications/domain/entities/notification_number_entity.dart';

abstract class NotificationNumberRepository {
  Future<NotificationNumberEntity> getUnreadCount();
}
