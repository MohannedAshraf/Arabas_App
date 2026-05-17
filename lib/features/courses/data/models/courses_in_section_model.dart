import 'package:arabas_app/features/courses/domain/entities/courses_in_section_entity.dart';

class CoursesInSectionModel extends CoursesInSectionEntity {
  CoursesInSectionModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.price,
    required super.rate,
    required super.duration,
  });

  factory CoursesInSectionModel.fromJson(Map<String, dynamic> json) {
    return CoursesInSectionModel(
      id: json["id"],
      title: json["title"],
      imageUrl: json["imageUrl"],
      price: (json["priceInEGP"] as num).toInt(),
      rate: json["rateStar"],
      duration: json["durationHours"],
    );
  }
}
