import 'package:arabas_app/features/practicals/domain/entity/practical_entity.dart';

abstract class PracticalRepository {
  Future<List<PracticalEntity>> getPracticals();
}
