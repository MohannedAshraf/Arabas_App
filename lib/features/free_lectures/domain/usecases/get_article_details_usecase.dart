import '../entities/article_details_entity.dart';
import '../repo/article_details_repo.dart';

class GetArticleDetailsUseCase {
  final ArticleDetailsRepo repo;

  GetArticleDetailsUseCase(this.repo);

  Future<ArticleDetailsEntity> call(String id) {
    return repo.getArticleById(id);
  }
}
