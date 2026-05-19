class CourseDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  final int priceInEGP;
  final int priceOutEGP;
  final int offer;

  final int durationHours;
  final String level;
  final String categoryName;

  final int videosCount;
  final int rateStar;
  final int rateTotal;

  final List<CourseVideoEntity> videos;

  CourseDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.priceInEGP,
    required this.priceOutEGP,
    required this.offer,
    required this.durationHours,
    required this.level,
    required this.categoryName,
    required this.videosCount,
    required this.rateStar,
    required this.rateTotal,
    required this.videos,
  });
}

class CourseVideoEntity {
  final String title;
  final String? url;
  final int order;
  final int durationSeconds;

  CourseVideoEntity({
    required this.title,
    required this.url,
    required this.order,
    required this.durationSeconds,
  });
}
