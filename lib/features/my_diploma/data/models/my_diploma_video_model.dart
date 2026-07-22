import '../../domain/entities/my_diploma_video_entity.dart';

class MyDiplomaVideoModel extends MyDiplomaVideoEntity {
  const MyDiplomaVideoModel({
    required super.currentVideo,
    required super.nextThreeVideos,
  });

  factory MyDiplomaVideoModel.fromJson(Map<String, dynamic> json) {
    return MyDiplomaVideoModel(
      currentVideo: CurrentVideoModel.fromJson(json["currentVideo"]),
      nextThreeVideos:
          (json["nextThreeVideos"] as List)
              .map((e) => NextVideoModel.fromJson(e))
              .toList(),
    );
  }
}

class CurrentVideoModel extends CurrentVideoEntity {
  CurrentVideoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.url,
    required super.durationSeconds,
    required super.order,
    required super.files,
    required super.quizzes,
  });

  factory CurrentVideoModel.fromJson(Map<String, dynamic> json) {
    return CurrentVideoModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      durationSeconds: json["durationSeconds"],
      order: json["order"],
      files:
          (json["files"] as List)
              .map((e) => VideoFileModel.fromJson(e))
              .toList(),
      quizzes:
          (json["quizzes"] as List)
              .map((e) => VideoQuizModel.fromJson(e))
              .toList(),
    );
  }
}

class VideoFileModel extends VideoFileEntity {
  VideoFileModel({
    required super.id,
    required super.fileName,
    required super.fileUrl,
    super.contentType,
    required super.fileSize,
  });

  factory VideoFileModel.fromJson(Map<String, dynamic> json) {
    return VideoFileModel(
      id: json["id"],
      fileName: json["fileName"],
      fileUrl: json["fileUrl"],
      contentType: json["contentType"],
      fileSize: json["fileSize"],
    );
  }
}

class VideoQuizModel extends VideoQuizEntity {
  VideoQuizModel({
    required super.id,
    required super.title,
    required super.createdAt,
  });

  factory VideoQuizModel.fromJson(Map<String, dynamic> json) {
    return VideoQuizModel(
      id: json["id"],
      title: json["title"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}

class NextVideoModel extends NextVideoEntity {
  NextVideoModel({
    required super.id,
    required super.title,
    required super.url,
    required super.durationSeconds,
    required super.order,
  });

  factory NextVideoModel.fromJson(Map<String, dynamic> json) {
    return NextVideoModel(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      durationSeconds: json["durationSeconds"],
      order: json["order"],
    );
  }
}
