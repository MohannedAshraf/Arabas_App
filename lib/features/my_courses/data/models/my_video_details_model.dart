import 'package:arabas_app/features/my_courses/domain/entity/my_video_details_entity.dart';

class MyVideoFileModel extends MyVideoFileEntity {
  MyVideoFileModel({
    required super.id,
    required super.title,
    required super.url,
    required super.publicId,
    required super.createdAt,
    required super.size,
  });

  factory MyVideoFileModel.fromJson(Map<String, dynamic> json) {
    return MyVideoFileModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      url: json["url"] ?? "",
      publicId: json["publicId"],
      createdAt: json["createdAt"] ?? "",
      size: json["size"],
    );
  }
}

class MyVideoDetailsModel extends MyVideoDetailsEntity {
  MyVideoDetailsModel({
    required super.id,
    required super.title,
    required super.url,
    required super.description,
    required super.order,
    required super.courseTitle,
    required super.durationSeconds,
    required super.files,
  });

  factory MyVideoDetailsModel.fromJson(Map<String, dynamic> json) {
    return MyVideoDetailsModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      url: json["url"] ?? "",
      description: json["description"] ?? "",
      order: json["order"] ?? 0,
      courseTitle: json["courseTitle"] ?? "",
      durationSeconds: json["durationSeconds"] ?? 0,

      files:
          (json["files"] as List?)
              ?.map((e) => MyVideoFileModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
