abstract class ProgressRepository {
  Future<bool> trackProgress({
    required String lessonId,
    required int positionSeconds,
  });
}
