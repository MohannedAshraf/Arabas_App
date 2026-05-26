import 'package:arabas_app/features/certificates/domain/entities/my_certificates_entity.dart';

abstract class CertificateRepository {
  Future<List<CertificateEntity>> getMyCertificates();
}
