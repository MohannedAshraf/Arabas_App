import 'package:arabas_app/core/services/notification_api_service.dart';
import 'package:arabas_app/features/notifications/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationResponseModel> getNotifications(int pageNumber);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final NotificationApiService apiService;

  NotificationRemoteDataSourceImpl(this.apiService);

  @override
  Future<NotificationResponseModel> getNotifications(int pageNumber) async {
    final response = await apiService.getNotifications(pageNumber: pageNumber);

    return NotificationResponseModel.fromJson(response.data);
  }
}
