abstract class ProgressRemoteDataSource {
  Future<bool> trackProgress({
    required String lessonId,
    required int positionSeconds,
  });
}
