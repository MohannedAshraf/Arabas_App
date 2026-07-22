import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_details_entity.dart';

abstract class MyDiplomaDetailsRepository {
  Future<MyDiplomaDetailsEntity> getMyDiplomaDetails({
    required String diplomaId,
  });
}
