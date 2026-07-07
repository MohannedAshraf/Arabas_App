class MyCourseDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String imagePublicId;

  final double priceInEGP;
  final double priceOutEGP;
  final int offer;

  final int durationHours;
  final int rateStars;
  final int totalRate;

  final String level;
  final String categoryId;

  final bool isPublished;

  final DateTime createdAt;

  final List<CourseVideoEntity> videos;

  const MyCourseDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.imagePublicId,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.durationHours,
    required this.rateStars,
    required this.totalRate,
    required this.level,
    required this.categoryId,
    required this.isPublished,
    required this.createdAt,
    required this.videos,
  });
}

class CourseVideoEntity {
  final String id;
  final String title;
  final int durationMinutes;
  final int order;
  final int lastPositionSeconds;

  const CourseVideoEntity({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.order,
    required this.lastPositionSeconds,
  });
}
