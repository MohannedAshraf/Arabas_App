import 'package:arabas_app/features/free_lectures/domain/entities/video_details_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.title,
    required super.videoUrl,
    super.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return VideoModel(
      id: data['id'],
      title: data['title'],
      videoUrl: data['videoUrl'],
      description: data['description'],
    );
  }
}
