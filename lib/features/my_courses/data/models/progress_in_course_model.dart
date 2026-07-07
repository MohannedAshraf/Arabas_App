import 'package:arabas_app/features/my_courses/domain/entity/progress_in_course_entity.dart';

class ProgressInCourseModel extends ProgressInCourseEntity {
  const ProgressInCourseModel({
    required super.lessonId,
    required super.lessonTitle,
    required super.courseId,
    required super.courseTitle,
    required super.lastPositionSeconds,
    required super.durationSeconds,
    required super.lastAccessedAt,
    required super.watchPercent,
    required super.isCompleted,
  });

  factory ProgressInCourseModel.fromJson(Map<String, dynamic> json) {
    return ProgressInCourseModel(
      lessonId: json['lessonId'] ?? '',
      lessonTitle: json['lessonTitle'] ?? '',
      courseId: json['courseId'] ?? '',
      courseTitle: json['courseTitle'] ?? '',
      lastPositionSeconds: json['lastPositionSeconds'] ?? 0,
      durationSeconds: json['durationSeconds'] ?? 0,
      lastAccessedAt:
          DateTime.tryParse(json['lastAccessedAt'] ?? '') ?? DateTime.now(),
      watchPercent: json['watchPercent'] ?? 0,
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
