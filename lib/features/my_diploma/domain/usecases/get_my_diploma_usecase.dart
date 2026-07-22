import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_entity.dart';
import 'package:arabas_app/features/my_diploma/domain/repo/my_diploma_repo.dart';

class GetMyDiplomasUseCase {
  final MyDiplomaRepository repository;

  GetMyDiplomasUseCase({required this.repository});

  Future<List<MyDiplomaEntity>> call({required bool activeOnly}) {
    return repository.getMyDiplomas(activeOnly: activeOnly);
  }
}
