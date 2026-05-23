// my_course_model.dart

import 'package:arabas_app/features/my_courses/domain/entity/my_courses_entity.dart';

class MyCourseModel extends MyCourseEntity {
  const MyCourseModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.priceInEGP,
    required super.priceOutEGP,
    required super.offer,
    required super.durationHours,
    required super.rateStar,
    required super.videoCount,
    required super.enrollDate,
    required super.expiryDate,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      priceInEGP: (json["priceInEGP"] ?? 0).toDouble(),
      priceOutEGP: (json["priceOutEGP"] ?? 0).toDouble(),
      offer: json["offer"] ?? 0,
      durationHours: json["durationHours"] ?? 0,
      rateStar: json["rateStar"] ?? 0,
      videoCount: json["videoCount"] ?? 0,
      enrollDate: DateTime.parse(json["enrollDate"]),
      expiryDate: DateTime.parse(json["expiryDate"]),
    );
  }
}
