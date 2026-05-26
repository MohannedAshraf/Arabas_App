import 'package:arabas_app/features/certificates/data/data%20sources/my_certificates_remote_data_source.dart';
import 'package:arabas_app/features/certificates/domain/entities/my_certificates_entity.dart';
import 'package:arabas_app/features/certificates/domain/repo/my_certificates_repo.dart';

class CertificateRepositoryImpl implements CertificateRepository {
  final CertificateRemoteDataSource remoteDataSource;

  CertificateRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CertificateEntity>> getMyCertificates() {
    return remoteDataSource.getMyCertificates();
  }
}
