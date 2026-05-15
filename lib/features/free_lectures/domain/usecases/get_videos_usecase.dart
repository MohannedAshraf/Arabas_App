import 'package:arabas_app/features/free_lectures/domain/repo/free_content_repo.dart';

import '../entities/free_content_entity.dart';

class GetVideosUseCase {
  final FreeContentRepo repo;
  GetVideosUseCase(this.repo);

  Future<List<FreeVideoEntity>> call() => repo.getVideos();
}
