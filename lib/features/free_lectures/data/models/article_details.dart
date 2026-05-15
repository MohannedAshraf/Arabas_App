import '../../domain/entities/article_details_entity.dart';

class ArticleDetailsModel extends ArticleDetailsEntity {
  ArticleDetailsModel({
    required super.id,
    required super.title,
    required super.content,
    required super.createdAt,
  });

  factory ArticleDetailsModel.fromJson(Map<String, dynamic> json) {
    return ArticleDetailsModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }
}
