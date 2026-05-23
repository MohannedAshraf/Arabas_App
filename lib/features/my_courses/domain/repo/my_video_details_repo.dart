import 'package:arabas_app/features/my_courses/domain/entity/my_video_details_entity.dart';

abstract class MyVideoDetailsRepo {
  Future<MyVideoDetailsEntity> getVideoDetails(String videoId);
}
