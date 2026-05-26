import 'package:arabas_app/features/certificates/domain/entities/my_certificates_entity.dart';
import 'package:arabas_app/features/certificates/domain/repo/my_certificates_repo.dart';

class GetMyCertificatesUseCase {
  final CertificateRepository repository;

  GetMyCertificatesUseCase(this.repository);

  Future<List<CertificateEntity>> call() {
    return repository.getMyCertificates();
  }
}
