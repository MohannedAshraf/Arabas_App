class MyDiplomaVideoEntity {
  final CurrentVideoEntity currentVideo;
  final List<NextVideoEntity> nextThreeVideos;

  const MyDiplomaVideoEntity({
    required this.currentVideo,
    required this.nextThreeVideos,
  });
}

class CurrentVideoEntity {
  final String id;
  final String title;
  final String description;
  final String url;
  final int durationSeconds;
  final int order;

  final List<VideoFileEntity> files;
  final List<VideoQuizEntity> quizzes;

  const CurrentVideoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.durationSeconds,
    required this.order,
    required this.files,
    required this.quizzes,
  });
}

class VideoFileEntity {
  final String id;
  final String fileName;
  final String fileUrl;
  final String? contentType;
  final int fileSize;

  const VideoFileEntity({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    this.contentType,
    required this.fileSize,
  });
}

class VideoQuizEntity {
  final String id;
  final String title;
  final DateTime createdAt;

  const VideoQuizEntity({
    required this.id,
    required this.title,
    required this.createdAt,
  });
}

class NextVideoEntity {
  final String id;
  final String title;
  final String url;
  final int durationSeconds;
  final int order;

  const NextVideoEntity({
    required this.id,
    required this.title,
    required this.url,
    required this.durationSeconds,
    required this.order,
  });
}
