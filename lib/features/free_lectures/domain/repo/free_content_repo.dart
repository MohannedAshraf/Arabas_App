import '../entities/free_content_entity.dart';

abstract class FreeContentRepo {
  Future<List<FreeArticleEntity>> getArticles();
  Future<List<FreeVideoEntity>> getVideos();
}
