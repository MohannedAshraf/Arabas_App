import 'package:arabas_app/features/diplomas/domain/entities/diploma_details_entity.dart';

abstract class DiplomaDetailsRepository {
  Future<DiplomaDetailsEntity> getDiplomaDetails(String id);
}
