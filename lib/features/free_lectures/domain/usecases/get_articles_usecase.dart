import 'package:arabas_app/features/free_lectures/domain/repo/free_content_repo.dart';

import '../entities/free_content_entity.dart';

class GetArticlesUseCase {
  final FreeContentRepo repo;
  GetArticlesUseCase(this.repo);

  Future<List<FreeArticleEntity>> call() => repo.getArticles();
}
