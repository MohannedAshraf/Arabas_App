class FreeArticleModel {
  final String id;
  final String title;
  final String createdAt;

  FreeArticleModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory FreeArticleModel.fromJson(Map<String, dynamic> json) {
    return FreeArticleModel(
      id: json['id'],
      title: json['title'],
      createdAt: json['createdAt'],
    );
  }
}

class FreeVideoModel {
  final String id;
  final String title;
  final String createdAt;
  final String videoUrl;

  FreeVideoModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.videoUrl,
  });

  factory FreeVideoModel.fromJson(Map<String, dynamic> json) {
    return FreeVideoModel(
      id: json['id'],
      title: json['title'],
      createdAt: json['createdAt'],
      videoUrl: json['videoUrl'],
    );
  }
}
