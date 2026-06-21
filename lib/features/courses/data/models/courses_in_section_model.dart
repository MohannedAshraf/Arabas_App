import 'package:arabas_app/features/courses/domain/entities/courses_in_section_entity.dart';

class CoursesInSectionModel extends CoursesInSectionEntity {
  CoursesInSectionModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.imagePublicId,
    required super.priceInEGP,
    required super.priceOutEGP,
    required super.offer,
    required super.categoryName,
    required super.isPublished,
    required super.created,
    required super.durationHours,
    required super.rateStar,
    required super.videoCount,
  });

  factory CoursesInSectionModel.fromJson(Map<String, dynamic> json) {
    return CoursesInSectionModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      imagePublicId: json["imagePublicId"],

      priceInEGP: (json["priceInEGP"] ?? 0).toInt(),
      priceOutEGP: (json["priceOutEGP"] ?? 0).toInt(),

      offer: (json["offer"] ?? 0).toInt(),

      categoryName: json["categoryName"] ?? "",

      isPublished: json["isPublished"] ?? false,

      created: json["created"] ?? "",

      durationHours: (json["durationHours"] ?? 0).toInt(),

      rateStar: (json["rateStar"] ?? 0).toInt(),

      videoCount: (json["videoCount"] ?? 0).toInt(),
    );
  }
}
