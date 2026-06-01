import 'package:arabas_app/features/diplomas/data/data_sources/diplomas_remote_data_source.dart';
import 'package:arabas_app/features/diplomas/domain/entities/diplomas_entity.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diplomas_repo.dart';

class DiplomaRepositoryImpl implements DiplomaRepository {
  final DiplomaRemoteDataSource remoteDataSource;

  DiplomaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<DiplomaEntity>> getDiplomas() {
    return remoteDataSource.getDiplomas();
  }
}
