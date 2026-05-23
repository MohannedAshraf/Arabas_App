import 'package:arabas_app/features/my_courses/domain/entity/my_video_details_entity.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_video_details_repo.dart';

class GetMyVideoDetailsUsecase {
  final MyVideoDetailsRepo repo;

  GetMyVideoDetailsUsecase(this.repo);

  Future<MyVideoDetailsEntity> call(String videoId) {
    return repo.getVideoDetails(videoId);
  }
}
