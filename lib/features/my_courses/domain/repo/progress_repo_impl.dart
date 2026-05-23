import 'package:arabas_app/features/my_courses/data/data_sources/progress_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/domain/repo/progress_repo.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressRemoteDataSource remoteDataSource;

  ProgressRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> trackProgress({
    required String lessonId,
    required int positionSeconds,
  }) async {
    return await remoteDataSource.trackProgress(
      lessonId: lessonId,
      positionSeconds: positionSeconds,
    );
  }
}
