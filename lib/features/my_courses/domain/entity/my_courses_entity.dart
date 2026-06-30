class MyCourseEntity {
  final String id;
  final DateTime enrollDate;
  final DateTime expiryDate;
  final String title;
  final String imageUrl;
  final double priceInEGP;
  final double priceOutEGP;
  final int offer;
  final DateTime created;
  final int durationHours;
  final int rateStar;
  final int videoCount;
  final int progressPercent;

  const MyCourseEntity({
    required this.id,
    required this.enrollDate,
    required this.expiryDate,
    required this.title,
    required this.imageUrl,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.created,
    required this.durationHours,
    required this.rateStar,
    required this.videoCount,
    required this.progressPercent,
  });
}
