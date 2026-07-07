class ProgressInCourseEntity {
  final String lessonId;
  final String lessonTitle;
  final String courseId;
  final String courseTitle;
  final int lastPositionSeconds;
  final int durationSeconds;
  final DateTime lastAccessedAt;
  final int watchPercent;
  final bool isCompleted;

  const ProgressInCourseEntity({
    required this.lessonId,
    required this.lessonTitle,
    required this.courseId,
    required this.courseTitle,
    required this.lastPositionSeconds,
    required this.durationSeconds,
    required this.lastAccessedAt,
    required this.watchPercent,
    required this.isCompleted,
  });
}
