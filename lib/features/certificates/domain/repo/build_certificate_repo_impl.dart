import 'package:arabas_app/features/certificates/data/data%20sources/build_certificate_remote_data_source.dart';
import 'package:arabas_app/features/certificates/domain/entities/build_certificate_entity.dart';
import 'package:arabas_app/features/certificates/domain/repo/build_certificate_repo.dart';

class BuildCertificateRepositoryImpl implements BuildCertificateRepository {
  final BuildCertificateRemoteDataSource remoteDataSource;

  BuildCertificateRepositoryImpl(this.remoteDataSource);

  @override
  Future<BuildCertificateEntity> checkCertificate({
    required String courseId,
  }) async {
    return await remoteDataSource.checkCertificate(courseId: courseId);
  }
}
