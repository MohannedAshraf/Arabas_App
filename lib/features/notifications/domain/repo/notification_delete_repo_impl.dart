import 'package:arabas_app/features/notifications/data/data_sources/notification_delete_remote_data_source.dart';
import 'package:arabas_app/features/notifications/domain/entities/delete_notification_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_delete_repo.dart';

class NotificationDeleteRepositoryImpl implements NotificationDeleteRepository {
  final NotificationDeleteRemoteDataSource remoteDataSource;

  NotificationDeleteRepositoryImpl(this.remoteDataSource);

  @override
  Future<DeleteNotificationEntity> deleteNotification(String id) async {
    return await remoteDataSource.deleteNotification(id);
  }
}
