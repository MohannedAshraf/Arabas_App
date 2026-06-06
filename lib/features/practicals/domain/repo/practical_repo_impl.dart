import 'package:arabas_app/features/practicals/data/data_sources/practical_remote_data_source.dart';
import 'package:arabas_app/features/practicals/domain/entity/practical_entity.dart';
import 'package:arabas_app/features/practicals/domain/repo/practical_repo.dart';

class PracticalRepositoryImpl implements PracticalRepository {
  final PracticalRemoteDataSource remoteDataSource;

  PracticalRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PracticalEntity>> getPracticals() {
    return remoteDataSource.getPracticals();
  }
}
