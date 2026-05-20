class CourseBookDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final List<ChapterEntity> chapters;

  CourseBookDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.chapters,
  });
}

class ChapterEntity {
  final String id;
  final String title;
  final String description;
  final int order;
  final String url;

  ChapterEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.url,
  });
}
