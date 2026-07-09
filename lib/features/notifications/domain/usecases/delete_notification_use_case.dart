import 'package:arabas_app/features/notifications/domain/entities/delete_notification_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_delete_repo.dart';

class DeleteNotificationUseCase {
  final NotificationDeleteRepository repository;

  DeleteNotificationUseCase(this.repository);

  Future<DeleteNotificationEntity> call(String id) async {
    return repository.deleteNotification(id);
  }
}
