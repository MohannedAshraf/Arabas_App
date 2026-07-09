import 'package:arabas_app/features/announcement/domain/entities/announcement_entity.dart';
import 'package:arabas_app/features/announcement/domain/repo/announcement_repo.dart';

class GetActiveAnnouncementsUseCase {
  final AnnouncementRepository repository;

  GetActiveAnnouncementsUseCase(this.repository);

  Future<List<AnnouncementEntity>> call() async {
    return await repository.getActiveAnnouncements();
  }
}