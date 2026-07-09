import 'package:arabas_app/features/notifications/data/data_sources/notification_read_remote_data_source.dart';
import 'package:arabas_app/features/notifications/domain/entities/read_notification_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_read_repo.dart';

class NotificationReadRepositoryImpl implements NotificationReadRepository {
  final NotificationReadRemoteDataSource remoteDataSource;

  NotificationReadRepositoryImpl(this.remoteDataSource);

  @override
  Future<ReadNotificationEntity> readNotification(String id) async {
    return await remoteDataSource.readNotification(id);
  }
}
