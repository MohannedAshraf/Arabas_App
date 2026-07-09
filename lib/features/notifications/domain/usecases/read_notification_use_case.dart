import 'package:arabas_app/features/notifications/domain/entities/read_notification_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_read_repo.dart';

class ReadNotificationUseCase {
  final NotificationReadRepository repository;

  ReadNotificationUseCase(this.repository);

  Future<ReadNotificationEntity> call(String id) async {
    return await repository.readNotification(id);
  }
}
