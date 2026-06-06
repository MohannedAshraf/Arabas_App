import 'package:arabas_app/features/practicals/data/data_sources/practical_details_remote_data_source.dart';
import 'package:arabas_app/features/practicals/domain/entity/practical_details_entity.dart';
import 'package:arabas_app/features/practicals/domain/repo/practical_details_repo.dart';

class PracticalDetailsRepositoryImpl implements PracticalDetailsRepository {
  final PracticalDetailsRemoteDataSource remote;

  PracticalDetailsRepositoryImpl(this.remote);

  @override
  Future<PracticalDetailsEntity> getDetails(String id) {
    return remote.getDetails(id);
  }
}
