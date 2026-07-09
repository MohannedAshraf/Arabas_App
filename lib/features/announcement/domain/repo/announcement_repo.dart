import 'package:arabas_app/features/announcement/domain/entities/announcement_entity.dart';

abstract class AnnouncementRepository {
  Future<List<AnnouncementEntity>> getActiveAnnouncements();
}
