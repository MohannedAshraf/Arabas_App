import 'package:arabas_app/features/certificates/domain/entities/build_certificate_entity.dart';
import 'package:arabas_app/features/certificates/domain/repo/build_certificate_repo.dart';

class BuildCertificateUseCase {
  final BuildCertificateRepository repository;

  BuildCertificateUseCase(this.repository);

  Future<BuildCertificateEntity> call({required String courseId}) async {
    return await repository.checkCertificate(courseId: courseId);
  }
}
