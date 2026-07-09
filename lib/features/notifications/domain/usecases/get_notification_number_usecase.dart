import 'package:arabas_app/features/notifications/domain/entities/notification_number_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_number_repo.dart';

class GetNotificationNumberUseCase {
  final NotificationNumberRepository repository;

  GetNotificationNumberUseCase(this.repository);

  Future<NotificationNumberEntity> call() {
    return repository.getUnreadCount();
  }
}
