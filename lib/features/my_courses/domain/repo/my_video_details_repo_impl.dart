import 'package:arabas_app/features/my_courses/data/data_sources/my_video_details_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/domain/entity/my_video_details_entity.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_video_details_repo.dart';

class MyVideoDetailsRepoImpl implements MyVideoDetailsRepo {
  final MyVideoDetailsRemoteDataSource remoteDataSource;

  MyVideoDetailsRepoImpl(this.remoteDataSource);

  @override
  Future<MyVideoDetailsEntity> getVideoDetails(String videoId) {
    return remoteDataSource.getVideoDetails(videoId);
  }
}
