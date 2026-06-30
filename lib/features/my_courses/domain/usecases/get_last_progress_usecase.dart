import 'package:arabas_app/features/my_courses/domain/repo/last_progress_repo.dart';

import '../entity/last_progress_entity.dart';

class GetLastThreeProgressUseCase {
  final LastProgressRepo repo;

  GetLastThreeProgressUseCase(this.repo);

  Future<List<LastProgressEntity>> call() {
    return repo.getLastThreeProgress();
  }
}
