import 'package:arabas_app/features/my_courses/domain/entity/my_courses_entity.dart';

class MyCourseModel extends MyCourseEntity {
  const MyCourseModel({
    required super.id,
    required super.enrollDate,
    required super.expiryDate,
    required super.title,
    required super.imageUrl,
    required super.priceInEGP,
    required super.priceOutEGP,
    required super.offer,
    required super.created,
    required super.durationHours,
    required super.rateStar,
    required super.videoCount,
    required super.progressPercent,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: json["id"] ?? "",
      enrollDate: DateTime.tryParse(json["enrollDate"] ?? "") ?? DateTime.now(),
      expiryDate: DateTime.tryParse(json["expiryDate"] ?? "") ?? DateTime.now(),
      title: json["title"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      priceInEGP: (json["priceInEGP"] ?? 0).toDouble(),
      priceOutEGP: (json["priceOutEGP"] ?? 0).toDouble(),
      offer: json["offer"] ?? 0,
      created: DateTime.tryParse(json["created"] ?? "") ?? DateTime.now(),
      durationHours: json["durationHours"] ?? 0,
      rateStar: json["rateStar"] ?? 0,
      videoCount: json["videoCount"] ?? 0,
      progressPercent: json["progressPercent"] ?? 0,
    );
  }
}
