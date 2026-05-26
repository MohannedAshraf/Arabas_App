import 'package:arabas_app/features/certificates/domain/entities/my_certificates_entity.dart';

abstract class CertificateState {}

class CertificateInitial extends CertificateState {}

class CertificateLoading extends CertificateState {}

class CertificateSuccess extends CertificateState {
  final List<CertificateEntity> certificates;

  CertificateSuccess(this.certificates);
}

class CertificateError extends CertificateState {
  final String message;

  CertificateError(this.message);
}
