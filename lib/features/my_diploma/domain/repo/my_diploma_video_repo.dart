import '../entities/my_diploma_video_entity.dart';

abstract class MyDiplomaVideoRepository {
  Future<MyDiplomaVideoEntity> getVideo(String videoId);
}
