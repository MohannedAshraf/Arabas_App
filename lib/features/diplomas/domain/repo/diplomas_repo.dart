import 'package:arabas_app/features/diplomas/domain/entities/diplomas_entity.dart';

abstract class DiplomaRepository {
  Future<List<DiplomaEntity>> getDiplomas();
}
