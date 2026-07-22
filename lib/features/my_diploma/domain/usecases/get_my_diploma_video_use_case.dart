import 'package:arabas_app/features/my_diploma/domain/repo/my_diploma_video_repo.dart';

import '../entities/my_diploma_video_entity.dart';

class GetMyDiplomaVideoUseCase {
  final MyDiplomaVideoRepository repository;

  GetMyDiplomaVideoUseCase(this.repository);

  Future<MyDiplomaVideoEntity> call(String videoId) {
    return repository.getVideo(videoId);
  }
}
