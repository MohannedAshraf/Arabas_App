import 'package:arabas_app/features/free_lectures/domain/entities/video_details_entity.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/video_details_repo.dart';

class GetVideoByIdUseCase {
  final FreeVideoRepository repository;

  GetVideoByIdUseCase(this.repository);

  Future<VideoEntity> call(String id) async {
    return await repository.getVideoById(id);
  }
}
