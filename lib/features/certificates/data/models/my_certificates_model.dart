import 'package:arabas_app/features/certificates/domain/entities/my_certificates_entity.dart';

class CertificateModel extends CertificateEntity {
  CertificateModel({
    required super.certificateId,
    required super.courseId,
    required super.courseName,
    required super.studentName,
    required super.scorePercentage,
    required super.totalVideo,
    required super.certificateTitle,
    required super.certificateNumber,
    required super.verificationUrl,
    required super.certificateUrl,
    required super.issuedDate,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      certificateId: json["certificateId"],
      courseId: json["courseId"],
      courseName: json["courseName"],
      studentName: json["studentName"],
      scorePercentage: json["scorePercentage"],
      totalVideo: json["totalVideo"],
      certificateTitle: json["certificateTitle"],
      certificateNumber: json["certificateNumber"],
      verificationUrl: json["verificationUrl"],
      certificateUrl: json["certificateUrl"],
      issuedDate: DateTime.parse(json["issuedDate"]),
    );
  }
}
