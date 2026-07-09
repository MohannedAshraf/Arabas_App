import 'package:arabas_app/features/notifications/data/data_sources/notification_remote_data_source.dart';
import 'package:arabas_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:arabas_app/features/notifications/domain/repo/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<NotificationPageEntity> getNotifications(int pageNumber) async {
    final response = await remoteDataSource.getNotifications(pageNumber);

    return NotificationPageEntity(
      pageNumber: response.pageNumber,
      totalPages: response.totalPages,
      hasNextPage: response.hasNextPage,
      notifications:
          response.notifications
              .map(
                (e) => NotificationEntity(
                  id: e.id,
                  title: e.title,
                  body: e.body,
                  isRead: e.isRead,
                  createdAt: e.createdAt,
                ),
              )
              .toList(),
    );
  }
}
