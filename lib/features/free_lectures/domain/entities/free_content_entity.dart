class FreeArticleEntity {
  final String id;
  final String title;
  final String createdAt;

  FreeArticleEntity({
    required this.id,
    required this.title,
    required this.createdAt,
  });
}

class FreeVideoEntity {
  final String id;
  final String title;
  final String createdAt;
  final String videoUrl;

  FreeVideoEntity({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.videoUrl,
  });
}
