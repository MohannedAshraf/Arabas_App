class MyVideoFileEntity {
  final String id;
  final String title;
  final String url;
  final String? publicId;
  final String createdAt;
  final dynamic size;

  MyVideoFileEntity({
    required this.id,
    required this.title,
    required this.url,
    required this.publicId,
    required this.createdAt,
    required this.size,
  });
}

class MyVideoDetailsEntity {
  final String id;
  final String title;
  final String url;
  final String description;
  final int order;
  final String courseTitle;
  final int durationSeconds;

  final List<MyVideoFileEntity> files;

  MyVideoDetailsEntity({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.order,
    required this.courseTitle,
    required this.durationSeconds,
    required this.files,
  });
}
