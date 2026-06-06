import 'package:arabas_app/features/practicals/domain/entity/practical_details_entity.dart';

abstract class PracticalDetailsRepository {
  Future<PracticalDetailsEntity> getDetails(String id);
}
