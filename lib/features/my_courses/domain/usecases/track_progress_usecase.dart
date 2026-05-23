import 'package:arabas_app/features/my_courses/domain/repo/progress_repo.dart';

class TrackProgressUseCase {
  final ProgressRepository repository;

  TrackProgressUseCase(this.repository);

  Future<bool> call({
    required String lessonId,
    required int positionSeconds,
  }) async {
    return await repository.trackProgress(
      lessonId: lessonId,
      positionSeconds: positionSeconds,
    );
  }
}
