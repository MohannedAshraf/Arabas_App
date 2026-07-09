import 'package:arabas_app/core/services/notification_api_service.dart';
import 'package:arabas_app/features/notifications/data/models/notification_number_model.dart';

abstract class NotificationNumberRemoteDataSource {
  Future<NotificationNumberModel> getUnreadCount();
}

class NotificationNumberRemoteDataSourceImpl
    implements NotificationNumberRemoteDataSource {
  final NotificationApiService apiService;

  NotificationNumberRemoteDataSourceImpl(this.apiService);

  @override
  Future<NotificationNumberModel> getUnreadCount() async {
    final response = await apiService.getUnreadCount();

    return NotificationNumberModel.fromJson(response.data);
  }
}
