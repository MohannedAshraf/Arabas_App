import 'package:arabas_app/features/free_lectures/domain/entities/video_details_entity.dart';

abstract class FreeVideoRepository {
  Future<VideoEntity> getVideoById(String id);
}
