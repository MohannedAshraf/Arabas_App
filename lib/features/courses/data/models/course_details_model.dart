import '../../domain/entities/course_details_entity.dart';

class CourseDetailsModel extends CourseDetailsEntity {
  CourseDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.priceInEGP,
    required super.priceOutEGP,
    required super.offer,
    required super.durationHours,
    required super.level,
    required super.categoryName,
    required super.videosCount,
    required super.rateStar,
    required super.rateTotal,
    required super.videos,
  });

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailsModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["imageUrl"] ?? "",

      priceInEGP: (json["priceInEGP"] ?? 0).toInt() ?? 0,
      priceOutEGP: (json["priceOutEGP"] ?? 0).toInt() ?? 0,
      offer: json["offer"] ?? 0,

      durationHours: json["durationHours"] ?? 0,
      level: json["level"] ?? "",
      categoryName: json["categoryName"] ?? "",

      videosCount: json["videosCount"] ?? 0,
      rateStar: json["rateStar"] ?? 0,
      rateTotal: json["rateTotal"] ?? 0,

      videos:
          (json["videos"] as List? ?? [])
              .map((e) => CourseVideoModel.fromJson(e))
              .toList(),
    );
  }
}

class CourseVideoModel extends CourseVideoEntity {
  CourseVideoModel({
    required super.title,
    required super.url,
    required super.order,
    required super.durationSeconds,
  });

  factory CourseVideoModel.fromJson(Map<String, dynamic> json) {
    return CourseVideoModel(
      title: json["title"] ?? "",
      url: json["url"],
      order: json["order"] ?? 0,
      durationSeconds: json["durationSeconds"] ?? 0,
    );
  }
}
