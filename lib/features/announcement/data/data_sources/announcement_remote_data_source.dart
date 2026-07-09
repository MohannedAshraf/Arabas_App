import 'package:arabas_app/core/services/notification_api_service.dart';
import 'package:arabas_app/features/announcement/data/models/announcement_model.dart';

abstract class AnnouncementRemoteDataSource {
  Future<List<AnnouncementModel>> getActiveAnnouncements();
}

class AnnouncementRemoteDataSourceImpl implements AnnouncementRemoteDataSource {
  final NotificationApiService apiService;

  AnnouncementRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<AnnouncementModel>> getActiveAnnouncements() async {
    final response = await apiService.getActiveAnnouncements();

    final List data = response.data["data"];

    return data.map((e) => AnnouncementModel.fromJson(e)).toList();
  }
}
