import 'package:arabas_app/features/my_courses/domain/entity/my_video_details_entity.dart';

class MyVideoFileModel extends MyVideoFileEntity {
  const MyVideoFileModel({
    required super.id,
    required super.title,
    required super.url,
    super.publicId,
    required super.createdAt,
    super.size,
  });

  factory MyVideoFileModel.fromJson(Map<String, dynamic> json) {
    return MyVideoFileModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      publicId: json['publicId']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
      size: json['size'],
    );
  }
}

class MyVideoDetailsModel extends MyVideoDetailsEntity {
  const MyVideoDetailsModel({
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
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      order: json['order'] ?? 0,
      courseTitle: json['courseTitle']?.toString() ?? '',
      durationSeconds: json['durationSeconds'] ?? 0,
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => MyVideoFileModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
