import 'package:arabas_app/features/certificates/domain/entities/build_certificate_entity.dart';

abstract class BuildCertificateRepository {
  Future<BuildCertificateEntity> checkCertificate({required String courseId});
}
