import 'package:arabas_app/features/free_lectures/data/data_sources/free_content_remote_data_source.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/free_content_repo.dart';

import '../../domain/entities/free_content_entity.dart';

class FreeContentRepoImpl implements FreeContentRepo {
  final FreeContentRemoteDataSource remote;

  FreeContentRepoImpl(this.remote);

  @override
  Future<List<FreeArticleEntity>> getArticles() async {
    final result = await remote.getArticles();
    return result
        .map(
          (e) => FreeArticleEntity(
            id: e.id,
            title: e.title,
            createdAt: e.createdAt,
          ),
        )
        .toList();
  }

  @override
  Future<List<FreeVideoEntity>> getVideos() async {
    final result = await remote.getVideos();
    return result
        .map(
          (e) => FreeVideoEntity(
            id: e.id,
            title: e.title,
            createdAt: e.createdAt,
            videoUrl: e.videoUrl,
          ),
        )
        .toList();
  }
}
