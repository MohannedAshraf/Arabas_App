import '../entity/last_progress_entity.dart';

abstract class LastProgressRepo {
  Future<List<LastProgressEntity>> getLastThreeProgress();
}
