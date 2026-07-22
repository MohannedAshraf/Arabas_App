import 'package:arabas_app/features/my_diploma/data/data_sources/my_diploma_video_remote-data_source.dart';
import 'package:arabas_app/features/my_diploma/domain/repo/my_diploma_video_repo.dart';

import '../../domain/entities/my_diploma_video_entity.dart';

class MyDiplomaVideoRepositoryImpl implements MyDiplomaVideoRepository {
  final MyDiplomaVideoRemoteDataSource remoteDataSource;

  MyDiplomaVideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<MyDiplomaVideoEntity> getVideo(String videoId) async {
    return await remoteDataSource.getVideo(videoId);
  }
}
