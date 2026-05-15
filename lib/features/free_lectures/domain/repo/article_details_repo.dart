import '../entities/article_details_entity.dart';

abstract class ArticleDetailsRepo {
  Future<ArticleDetailsEntity> getArticleById(String id);
}
