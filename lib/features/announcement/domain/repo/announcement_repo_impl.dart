import 'package:arabas_app/features/announcement/data/data_sources/announcement_remote_data_source.dart';
import 'package:arabas_app/features/announcement/domain/entities/announcement_entity.dart';
import 'package:arabas_app/features/announcement/domain/repo/announcement_repo.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDataSource remoteDataSource;

  AnnouncementRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AnnouncementEntity>> getActiveAnnouncements() async {
    return await remoteDataSource.getActiveAnnouncements();
  }
}
