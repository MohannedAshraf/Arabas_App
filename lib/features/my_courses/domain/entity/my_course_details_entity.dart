class MyCourseDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int durationHours;
  final int rateStars;

  final List<CourseVideoEntity> videos;

  const MyCourseDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.durationHours,
    required this.rateStars,
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
