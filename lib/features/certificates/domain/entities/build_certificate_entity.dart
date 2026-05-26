class BuildCertificateEntity {
  final bool eligible;
  final bool created;
  final String certificateId;
  final String certificateNumber;
  final String certificateUrl;
  final List<String> reasons;

  BuildCertificateEntity({
    required this.eligible,
    required this.created,
    required this.certificateId,
    required this.certificateNumber,
    required this.certificateUrl,
    required this.reasons,
  });
}
