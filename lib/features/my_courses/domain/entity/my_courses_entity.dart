// my_course_entity.dart

class MyCourseEntity {
  final String id;
  final String title;
  final String imageUrl;
  final double priceInEGP;
  final double priceOutEGP;
  final int offer;
  final int durationHours;
  final int rateStar;
  final int videoCount;
  final DateTime enrollDate;
  final DateTime expiryDate;

  const MyCourseEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.durationHours,
    required this.rateStar,
    required this.videoCount,
    required this.enrollDate,
    required this.expiryDate,
  });
}
