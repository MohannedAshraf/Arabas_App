import 'package:arabas_app/features/free_lectures/data/data_sources/video_details_data_source.dart';
import 'package:arabas_app/features/free_lectures/data/models/video_details_model.dart';
import 'package:arabas_app/features/free_lectures/domain/entities/video_details_entity.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/video_details_repo.dart';

class FreeVideoRepositoryImpl implements FreeVideoRepository {
  final FreeVideoRemoteDataSource remoteDataSource;

  FreeVideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<VideoEntity> getVideoById(String id) async {
    final json = await remoteDataSource.getVideoById(id);
    return VideoModel.fromJson(json);
  }
}
