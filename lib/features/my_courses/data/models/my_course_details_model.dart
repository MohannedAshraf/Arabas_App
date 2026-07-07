import 'package:arabas_app/features/my_courses/domain/entity/my_course_details_entity.dart';

class MyCourseDetailsModel extends MyCourseDetailsEntity {
  const MyCourseDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.imagePublicId,
    required super.priceInEGP,
    required super.priceOutEGP,
    required super.offer,
    required super.durationHours,
    required super.rateStars,
    required super.totalRate,
    required super.level,
    required super.categoryId,
    required super.isPublished,
    required super.createdAt,
    required super.videos,
  });

  factory MyCourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return MyCourseDetailsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      imagePublicId: json['imagePublicId'] ?? '',
      priceInEGP: (json['priceInEGP'] ?? 0).toDouble(),
      priceOutEGP: (json['priceOutEGP'] ?? 0).toDouble(),
      offer: json['offer'] ?? 0,
      durationHours: json['durationHours'] ?? 0,
      rateStars: json['rateStars'] ?? 0,
      totalRate: json['totalRate'] ?? 0,
      level: json['level'] ?? '',
      categoryId: json['categoryId'] ?? '',
      isPublished: json['isPublished'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      videos:
          (json['videos'] as List<dynamic>? ?? [])
              .map((e) => CourseVideoModel.fromJson(e))
              .toList(),
    );
  }
}

class CourseVideoModel extends CourseVideoEntity {
  const CourseVideoModel({
    required super.id,
    required super.title,
    required super.durationMinutes,
    required super.order,
    required super.lastPositionSeconds,
  });

  factory CourseVideoModel.fromJson(Map<String, dynamic> json) {
    return CourseVideoModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      durationMinutes: json['durationMinutes'] ?? 0,
      order: json['order'] ?? 0,
      lastPositionSeconds: json['lastPositionSeconds'] ?? 0,
    );
  }
}
