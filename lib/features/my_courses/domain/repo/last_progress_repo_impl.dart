import 'package:arabas_app/features/my_courses/data/data_sources/last_progress_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/domain/repo/last_progress_repo.dart';

import '../../domain/entity/last_progress_entity.dart';

class LastProgressRepoImpl implements LastProgressRepo {
  final LastProgressRemoteDataSource remote;

  LastProgressRepoImpl(this.remote);

  @override
  Future<List<LastProgressEntity>> getLastThreeProgress() {
    return remote.getLastThreeProgress();
  }
}
