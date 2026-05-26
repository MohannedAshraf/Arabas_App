import 'package:arabas_app/features/certificates/domain/entities/build_certificate_entity.dart';

abstract class BuildCertificateState {}

class BuildCertificateInitial extends BuildCertificateState {}

class BuildCertificateLoading extends BuildCertificateState {}

class BuildCertificateSuccess extends BuildCertificateState {
  final BuildCertificateEntity certificate;

  BuildCertificateSuccess(this.certificate);
}

class BuildCertificateError extends BuildCertificateState {
  final String message;

  BuildCertificateError(this.message);
}
