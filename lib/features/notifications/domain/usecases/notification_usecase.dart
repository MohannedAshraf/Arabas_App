import 'package:arabas_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_repo.dart';

class NotificationUseCase {
  final NotificationRepository repository;

  NotificationUseCase(this.repository);

  Future<NotificationPageEntity> call(int pageNumber) {
    return repository.getNotifications(pageNumber);
  }
}
