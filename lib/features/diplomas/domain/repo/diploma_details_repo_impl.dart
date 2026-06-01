import 'package:arabas_app/features/diplomas/data/data_sources/diploma_details_remote_data_source.dart';
import 'package:arabas_app/features/diplomas/domain/entities/diploma_details_entity.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diploma_details_repo.dart';

class DiplomaDetailsRepositoryImpl implements DiplomaDetailsRepository {
  final DiplomaDetailsRemoteDataSource remote;

  DiplomaDetailsRepositoryImpl(this.remote);

  @override
  Future<DiplomaDetailsEntity> getDiplomaDetails(String id) {
    return remote.getDiplomaDetails(id);
  }
}
