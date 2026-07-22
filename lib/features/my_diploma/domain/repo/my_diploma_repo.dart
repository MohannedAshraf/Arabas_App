import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_entity.dart';

abstract class MyDiplomaRepository {
  Future<List<MyDiplomaEntity>> getMyDiplomas({required bool activeOnly});
}
