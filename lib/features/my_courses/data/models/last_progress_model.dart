import '../../domain/entity/last_progress_entity.dart';

class LastProgressModel extends LastProgressEntity {
  const LastProgressModel({
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

  factory LastProgressModel.fromJson(Map<String, dynamic> json) {
    return LastProgressModel(
      lessonId: json["lessonId"] ?? "",
      lessonTitle: json["lessonTitle"] ?? "",
      courseId: json["courseId"] ?? "",
      courseTitle: json["courseTitle"] ?? "",
      lastPositionSeconds: json["lastPositionSeconds"] ?? 0,
      durationSeconds: json["durationSeconds"] ?? 0,
      lastAccessedAt:
          DateTime.tryParse(json["lastAccessedAt"] ?? "") ?? DateTime.now(),
      watchPercent: json["watchPercent"] ?? 0,
      isCompleted: json["isCompleted"] ?? false,
    );
  }
}
