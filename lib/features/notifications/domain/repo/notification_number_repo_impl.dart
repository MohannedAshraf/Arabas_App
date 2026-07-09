import 'package:arabas_app/features/notifications/data/data_sources/notification_number_remote_data_source.dart';
import 'package:arabas_app/features/notifications/domain/entities/notification_number_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_number_repo.dart';

class NotificationNumberRepositoryImpl implements NotificationNumberRepository {
  final NotificationNumberRemoteDataSource remoteDataSource;

  NotificationNumberRepositoryImpl(this.remoteDataSource);

  @override
  Future<NotificationNumberEntity> getUnreadCount() async {
    final response = await remoteDataSource.getUnreadCount();

    return NotificationNumberEntity(count: response.count);
  }
}
