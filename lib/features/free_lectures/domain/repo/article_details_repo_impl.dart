import 'package:arabas_app/features/free_lectures/data/data_sources/article_details_remote_data_source.dart';

import '../../domain/entities/article_details_entity.dart';
import '../../domain/repo/article_details_repo.dart';

class ArticleDetailsRepoImpl implements ArticleDetailsRepo {
  final ArticleDetailsRemoteDataSource remoteDataSource;

  ArticleDetailsRepoImpl(this.remoteDataSource);

  @override
  Future<ArticleDetailsEntity> getArticleById(String id) async {
    return await remoteDataSource.getArticleById(id);
  }
}
