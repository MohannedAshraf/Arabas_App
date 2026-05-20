class CourseBookDetailsModel {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final List<ChapterModel> chapters;

  CourseBookDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.chapters,
  });

  factory CourseBookDetailsModel.fromJson(Map<String, dynamic> json) {
    return CourseBookDetailsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createAt'],
      chapters:
          (json['chapters'] as List)
              .map((e) => ChapterModel.fromJson(e))
              .toList(),
    );
  }
}

class ChapterModel {
  final String id;
  final String title;
  final String description;
  final int order;
  final String url;

  ChapterModel({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.url,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      order: json['order'],
      url: json['url'],
    );
  }
}
