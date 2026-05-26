import 'package:arabas_app/features/certificates/domain/entities/build_certificate_entity.dart';

class BuildCertificateModel extends BuildCertificateEntity {
  final String message;

  BuildCertificateModel({
    required super.eligible,
    required super.created,
    required super.certificateId,
    required super.certificateNumber,
    required super.certificateUrl,
    required super.reasons,
    required this.message,
  });

  factory BuildCertificateModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return BuildCertificateModel(
      eligible: data['eligible'] ?? false,
      created: data['created'] ?? false,
      certificateId: data['certificateId'] ?? '',
      certificateNumber: data['certificateNumber'] ?? '',
      certificateUrl: data['certificateUrl'] ?? '',
      reasons:
          data['reasons'] != null ? List<String>.from(data['reasons']) : [],
      message: json['message'] ?? '',
    );
  }
}
