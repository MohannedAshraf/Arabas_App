class CertificateEntity {
  final String certificateId;
  final String courseId;
  final String courseName;
  final String studentName;
  final int scorePercentage;
  final int totalVideo;
  final String certificateTitle;
  final String certificateNumber;
  final String verificationUrl;
  final String certificateUrl;
  final DateTime issuedDate;

  CertificateEntity({
    required this.certificateId,
    required this.courseId,
    required this.courseName,
    required this.studentName,
    required this.scorePercentage,
    required this.totalVideo,
    required this.certificateTitle,
    required this.certificateNumber,
    required this.verificationUrl,
    required this.certificateUrl,
    required this.issuedDate,
  });
}
